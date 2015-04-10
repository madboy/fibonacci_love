local h = love.graphics.getHeight()
local w = love.graphics.getWidth()

local scale = 4
local count = 10
local maxCount = 19
local minCount = 4
local series = {}
local basecolors = {{255,255,0},
            {255,165,0},
            {255,140,0},
            {184,134,11},
            {250,128,114},
            {205,92,92},
            {165,42,42},
            {178,34,34},
            {255,99,71},
            {255,0,0},
            {210,105,30},
            {128,0,0},
            {255,0,255},
            {255,20,147},
            {208,32,144},
            {139,0,139},
            {46,139,87},
            {0,128,0},
            {107,142,35},
            {0,100,0},
            {0,191,255},
            {65,105,225},
            {0,0,255},
            {25,25,112},
            {219,112,147},
            {244,164,96},
            {255,160,122},
            {238,232,170},
            {60,179,113},
            {135,206,235}}

local colors = {}
local rectState = true

local rectangles = {}
local particles = {}

function fib(n)
    if n <= 0 then
        return 0
    elseif n == 1 then
        return 1
    else
        return fib(n-1) + fib(n-2)
    end
end

function fibonacci()
    local s = {}
    for i = 1,count do
        table.insert(s, 1, fib(i))
    end
    return s
end

function odd(v)
    if (v%2) == 0 then
        return false
    else
        return true
    end
end

function sum(t)
    local s = 0
    for _,v in ipairs(t) do
        s = s + v
    end
    return s
end

function getScale()
    local s = 0
    while (series[1]+series[2])*(s+0.1) < w do
        s = s + 0.1
    end
    return 1
end

function getColors()
    math.randomseed(os.time())
    local c = {}
    local base = basecolors
    for i = 1,#basecolors do
        local r = math.random(#base)
        table.insert(c, base[r])
        table.remove(base, r)
    end
    return c
end

function getRectangles(data)
    local series = data
    local ox = 0
    local oy = 0
    local r = {}
    for i,v in ipairs(series) do
        table.insert(r, {x=ox, y=oy, h=v, w=v})
        if odd(i) then
            ox = ox + v
        else
            oy = oy + v
        end
    end
    return r
end

function calculateWeights(data)
    local s = sum(data)
    local w = {}
    for _,v in ipairs(data) do
        table.insert(w, v/s)
    end
    return w
end

function printTable(t)
    for _,v in ipairs(t) do
        print(v)
    end
end

function printPairs(t)
    for k,v in pairs(t) do
        print(k,v)
    end
end

function getEqualRectangles(data)
    local series = calculateWeights(data)
    local divisions = {}
    local area = h * w
    local ox = 0
    local oy = 0
    local lh = h
    local lw = w
    for i,v in ipairs(series) do
        local r = {x=ox, y=oy, h=0, w=0}
        if odd(i) then
            r.h = lh
            r.w = (area * v) / r.h
            table.insert(divisions, r)
            ox = ox + r.w
            lw = lw - r.w
        else
            r.w = lw
            r.h = (area * v) / r.w
            table.insert(divisions, r)
            oy = oy + r.h
            lh = lh - r.h
        end
    end
    return divisions
end

function getParticles(data)
    local series = data
    local ox = 1
    local oy = 1
    local p = {}
    math.randomseed(os.time())
    for i,v in ipairs(series) do
        for c = 1,v do
            table.insert(p, {x=math.random(ox, ox+v), y=math.random(oy, oy+v), i=i})
        end
        if odd(i) then
            ox = ox + v
        else
            oy = oy + v
        end
    end
    return p
end

function regenerate()
    series = fibonacci()
    scale = getScale()
    --rectangles = getRectangles(series)
    rectangles = getEqualRectangles(series)
    particles = getParticles(series)
end

function love.load()
    love.graphics.setBackgroundColor(200, 200, 200)
    colors = getColors()
    regenerate()
end

function love.keypressed(key)
    if key == "up" then
        if count < maxCount then
            count = count + 1
            regenerate()
        end
    end
    if key == "down" then
        if count > minCount then
            count = count - 1
            regenerate()
        end
    end
    if key == "e" then
        rectState = not rectState
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(scale, scale)
    if rectState then
        for i,r in ipairs(rectangles) do
            love.graphics.setColor(colors[i])
            love.graphics.rectangle("fill", r.x, r.y, r.w, r.h)
        end
    else
        for _,p in ipairs(particles) do
            love.graphics.setColor(colors[p.i])
            love.graphics.point(p.x, p.y)
        end
    end
    love.graphics.pop()
    love.graphics.setColor(255,255,255)
    love.graphics.print(string.format("%d %d", #series, series[1]), 0, 0)
end

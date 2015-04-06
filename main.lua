local h = 600
local w = 800

local scale = 4
local count = 10
local series = {}
local colors = {{255,255,0, 255},
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
            {139,0,139}}

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

function setScale()
    local s = 0
    while (series[1]+series[2])*(s+0.1) < w do
        s = s + 0.1
    end
    return s
end

function love.conf(t)
    t.title = "fibonacci"
    t.screen.height = h
    t.screen.width = w
end

function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)
    series = fibonacci()
    scale = setScale()
end

function love.keypressed(key)
    if key == "up" then
        count = count + 1
        series = fibonacci()
        scale = setScale()
    end
    if key == "down" then
        count = count - 1
        series = fibonacci()
        scale = setScale()
        
    end
end

function love.draw()
    local x = 0
    local y = 0
    love.graphics.push()
    love.graphics.scale(scale, scale)
    for i,v in ipairs(series) do
        love.graphics.setColor(colors[i])
        love.graphics.rectangle("fill", x, y, v, v)
        if odd(i) then
            x = x + v
        else
            y = y + v
        end
    end
    love.graphics.pop()
    love.graphics.setColor(0,0,0)
    love.graphics.print(string.format("%d %d", #series, series[1]), 0, 0)
end

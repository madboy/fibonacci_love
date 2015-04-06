local scale = 8
local count = 9
local series = {}

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

function love.conf(t)
    t.title = "fibonacci"
    t.screen.height = 600
    t.screen.width = 800
end

function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)
    series = fibonacci()
end

function love.draw()
    local x = 0
    local y = 0
    love.graphics.scale(scale, scale)
    for i,v in ipairs(series) do
        love.graphics.setColor(255/v, 255/v, 255/v)
        love.graphics.rectangle("fill", x, y, v, v)
        if odd(i) then
            x = x + v
        else
            y = y + v
        end
    end
end

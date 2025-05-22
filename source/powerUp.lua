player = require("source.player")
local powerUp = {}

powerUp.lista = {}
powerUp.speed = 100

function powerUp.load()
    powerUp.spriteLua = love.graphics.newImage("assets/playerLua.png")
    powerUp.spriteC = love.graphics.newImage("assets/playerC.png")
    powerUp.spritePython = love.graphics.newImage("assets/playerPython.png")

    math.randomseed(os.time() + os.clock() * 100000)
end

function powerUp.spawn()
    local tipo
    tipo = math.random(1, 3) -- Só linguagens enquanto não tiver tiro melhorado

    local p = {
        x = math.random(50, 600),
        y = -50,
        tipo = tipo,
    }

    table.insert(powerUp.lista, p)
end

function powerUp.update(dt)
    for i = #powerUp.lista, 1, -1 do
        local p = powerUp.lista[i]
        p.y = p.y + powerUp.speed * dt

        -- Remove se sair da tela
        if p.y > love.graphics.getHeight() then
            table.remove(powerUp.lista, i)
        end

        -- Colisão com o player
        if math.abs(p.x - player.x) < 30 and math.abs(p.y - player.y) < 30 then
            if p.tipo == 1 then
                player.linguagem = "lua"
            elseif p.tipo == 2 then
                player.linguagem = "Python"
            elseif p.tipo == 3 then
                player.linguagem = "C"
            end

            table.remove(powerUp.lista, i)
        end
    end
end

function powerUp.draw()
    for _, p in ipairs(powerUp.lista) do

        if p.tipo == 1 and player.linguagem ~= "lua" then
            love.graphics.draw(powerUp.spriteLua, p.x, p.y, 0, 0.1, 0.1)
        elseif p.tipo == 2 and player.linguagem ~= "Python" then
            love.graphics.draw(powerUp.spritePython, p.x, p.y, 0, 0.3, 0.3)
        elseif p.tipo == 3 and player.linguagem ~= "C" then
            love.graphics.draw(powerUp.spriteC, p.x, p.y, 0, 0.3, 0.3)
        end
    end
end

return powerUp
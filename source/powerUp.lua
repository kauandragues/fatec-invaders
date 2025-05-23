player = require("source.player")
local powerUp = {}

powerUp.lista = {}
powerUp.speed = 100

function powerUp.load()
    powerUp.spriteLua = love.graphics.newImage("assets/playerLua.png")
    powerUp.spriteC = love.graphics.newImage("assets/playerC.png")
    powerUp.spritePython = love.graphics.newImage("assets/playerPython.png")

    love.math.setRandomSeed(os.time() + os.clock() * 100000)
end

-- Retorna um tipo que não seja a linguagem atual do player
local function escolherTipoValido()
    local tipos = {1, 2, 3}
    local linguagens = { [1] = "Lua", [2] = "Python", [3] = "C" }

    -- Filtra para tipos diferentes da linguagem atual
    local tiposValidos = {}
    for _, t in ipairs(tipos) do
        if linguagens[t]:lower() ~= player.linguagem:lower() then
            table.insert(tiposValidos, t)
        end
    end

    if #tiposValidos == 0 then
        return nil -- Todas iguais, talvez não crie power-up
    end

    return tiposValidos[love.math.random(1, #tiposValidos)]
end

function powerUp.spawn()
    local tipo = escolherTipoValido()
    if not tipo then return end

    local p = {
        x = love.math.random(50, 600),
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

        -- Colisão simples com player
        if math.abs(p.x - player.x) < 30 and math.abs(p.y - player.y) < 30 then
            if p.tipo == 1 then
                player.linguagem = "Lua"
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
        if p.tipo == 1 and player.linguagem:lower() ~= "Lua" then
            love.graphics.draw(powerUp.spriteLua, p.x, p.y, 0, 0.1, 0.1)
        elseif p.tipo == 2 and player.linguagem:lower() ~= "Python" then
            love.graphics.draw(powerUp.spritePython, p.x, p.y, 0, 0.2, 0.2)
        elseif p.tipo == 3 and player.linguagem:lower() ~= "C" then
            love.graphics.draw(powerUp.spriteC, p.x, p.y, 0, 0.2, 0.2)
        end
    end
end

return powerUp
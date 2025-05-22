local Bullet = require("source.bullet")
local shotCooldown = 0

local player = {
    x = 300,
    y = 300,
    speed = 400,
    hp = 3,
    bullets = {},
    linguagem = "lua",
    pontuacao_final = 0,
    spriteLua = nil,
    spriteC = nil,
    spritePython = nil,
    sprite = nil,
    base_monitor = nil,
}

function player.init(screen_width, screen_height)
    player.screen_width = screen_width or love.graphics.getWidth()
    player.screen_height = screen_height or love.graphics.getHeight()
    player.linguagem = "lua"
    player.x = 300
    player.y = 300
end

function player.load()
    player.sprite = love.graphics.newImage("assets/player.png")
    player.base_monitor = love.graphics.newImage("assets/monitores.png")
    player.spriteLua = love.graphics.newImage("assets/playerLua.png")
    player.spriteC = love.graphics.newImage("assets/playerC.png")
    player.spritePython = love.graphics.newImage("assets/playerPython.png")
end

function player.update(dt)
    player.speed = 400

    -- Movimento
    if love.keyboard.isDown("right") and player.x < player.screen_width - 130 then
        player.x = player.x + player.speed * dt
    elseif love.keyboard.isDown("left") and player.x > -28 then
        player.x = player.x - player.speed * dt
    end

    if love.keyboard.isDown("down") and player.y < player.screen_height - 112 then
        player.y = player.y + player.speed * dt
    elseif love.keyboard.isDown("up") and player.y > -9 then
        player.y = player.y - player.speed * dt
    end

    -- Tiro (só se power-up ativado)
    shotCooldown = math.max(0, shotCooldown - dt)

    if love.keyboard.isDown("z") and shotCooldown == 0 then
        table.insert(player.bullets, Bullet:new(player.x + 74, player.y, 0, -1, 300))
        shotCooldown = 0.3 -- cooldown de 0.3s para o próximo tiro
    end

    -- Atualiza as balas
    for i = #player.bullets, 1, -1 do
        local bullet = player.bullets[i]
        bullet:update(dt)
        if bullet.y < -10 then
            table.remove(player.bullets, i)
        end
    end
end

function player.draw()
    -- Desenha o player de acordo com a linguagem
    if player.linguagem == "lua" then
        love.graphics.draw(player.spriteLua, player.x, player.y, 0, 0.1, 0.1)
    elseif player.linguagem == "C" then
        love.graphics.draw(player.spriteC, player.x, player.y, 0, 0.3, 0.3)
    elseif player.linguagem == "Python" then
        love.graphics.draw(player.spritePython, player.x, player.y, 0, 0.3, 0.3)
    end

    -- Desenha vidas
    if player.hp == 3 then
        love.graphics.draw(player.sprite, 280, 420, 0, 0.07, 0.07)
        love.graphics.draw(player.base_monitor, 90, 460, 0, 0.3, 0.3)
        love.graphics.draw(player.base_monitor, 520, 460, 0, 0.3, 0.3)
    elseif player.hp == 2 then 
        love.graphics.draw(player.sprite, 280, 420, 0, 0.07, 0.07)
        love.graphics.draw(player.base_monitor, 90, 460, 0, 0.3, 0.3)
    elseif player.hp == 1 then
        love.graphics.draw(player.sprite, 280, 420, 0, 0.07, 0.07)
    end

    -- Desenha as balas
    for _, bullet in ipairs(player.bullets) do
        bullet:draw()
    end
end

return player
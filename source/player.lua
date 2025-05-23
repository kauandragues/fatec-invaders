local Bullet = require("source.bullet")

local player = {
    x = 300,
    y = 300,
    speed = 400,
    hp = 3,
    bullets = {},
    linguagem = "Lua",
    pontuacao_final = 0,
    spriteLua = nil,
    spriteC = nil,
    spritePython = nil,
    sprite = nil,
    base_monitor = nil,
    sounds = {},
}

local shotCooldown = 0

-- Configurações específicas por linguagem
local config = {
    Lua = {
        speed = 400,
        bulletSpeed = 500,
        cooldown = 0.5,
    },
    C = {
        speed = 300,
        bulletSpeed = 700,
        cooldown = 0.3,
    },
    Python = {
        speed = 450,
        bulletSpeed = 400,
        cooldown = 0.7,
    }
}

function player.init(screen_width, screen_height)
    player.screen_width = screen_width or love.graphics.getWidth()
    player.screen_height = screen_height or love.graphics.getHeight()
    player.linguagem = "Python"
    player.x = 300
    player.y = 300

    player.sounds.bullet = love.audio.newSource("assets/bullet.mp3", "static")
    player.sounds.bullet:setVolume(0.2)
end

function player.load()
    player.sprite = love.graphics.newImage("assets/player.png")
    player.base_monitor = love.graphics.newImage("assets/monitores.png")
    player.spriteLua = love.graphics.newImage("assets/playerLua.png")
    player.spriteC = love.graphics.newImage("assets/playerC.png")
    player.spritePython = love.graphics.newImage("assets/playerPython.png")
end

function player.update(dt)
    -- Atualiza velocidade e cooldown baseado na linguagem
    local speed = config[player.linguagem].speed
    local bulletSpeed = config[player.linguagem].bulletSpeed
    local cooldownTime = config[player.linguagem].cooldown

    -- Movimento com WASD
    if love.keyboard.isDown("d") and player.x < player.screen_width - 130 then
        player.x = player.x + speed * dt
    elseif love.keyboard.isDown("a") and player.x > -28 then
        player.x = player.x - speed * dt
    end

    if love.keyboard.isDown("s") and player.y < player.screen_height - 112 then
        player.y = player.y + speed * dt
    elseif love.keyboard.isDown("w") and player.y > 100 then
        player.y = player.y - speed * dt
    end

    -- Controle de tiro pelo botão esquerdo do mouse
    shotCooldown = math.max(0, shotCooldown - dt)

    if love.mouse.isDown(1) and shotCooldown == 0 then
        local mouseX, mouseY = love.mouse.getPosition()

        local startX = player.x + 37 -- ajuste para centralizar o tiro
        local startY = player.y + 37

        local dirX = mouseX - startX
        local dirY = mouseY - startY

        local length = math.sqrt(dirX * dirX + dirY * dirY)
        if length == 0 then length = 1 end

        dirX = dirX / length
        dirY = dirY / length

        table.insert(player.bullets, Bullet:new(startX, startY, dirX, dirY, bulletSpeed))

        local snd = player.sounds.bullet:clone()
        snd:seek(1) -- começa do início
        snd:play()

        shotCooldown = cooldownTime
    end

    -- Atualiza balas
    for i = #player.bullets, 1, -1 do
        local bullet = player.bullets[i]
        bullet:update(dt)

        if bullet.x < -10 or bullet.x > player.screen_width + 10 or
           bullet.y < -10 or bullet.y > player.screen_height + 10 then
            table.remove(player.bullets, i)
        end
    end
end

function player.draw()
    -- Escolhe sprite do player
    if player.linguagem == "Lua" then
        love.graphics.draw(player.spriteLua, player.x, player.y, 0, 0.1, 0.1)
    elseif player.linguagem == "C" then
        love.graphics.draw(player.spriteC, player.x, player.y, 0, 0.2, 0.2)
    elseif player.linguagem == "Python" then
        love.graphics.draw(player.spritePython, player.x, player.y, 0, 0.2, 0.2)
    end

    -- Desenha vidas (monitores)
    local vidaPosicoes = {
        {280, 420}, {90, 460}, {520, 460}
    }
    for i = 1, player.hp do
        if i == 1 then
            love.graphics.draw(player.sprite, vidaPosicoes[i][1], vidaPosicoes[i][2], 0, 0.07, 0.07)
        else
            love.graphics.draw(player.base_monitor, vidaPosicoes[i][1], vidaPosicoes[i][2], 0, 0.3, 0.3)
        end
    end

    -- Desenha as balas
    for _, bullet in ipairs(player.bullets) do
        bullet:draw()
    end
end

return player

local player = require("source.player")
local enemy = {}

enemy.sprite1 = nil
enemy.sprite2 = nil
enemy.list = {}
local enemy_damage
local damage
local espera = 2
local time_nascimento = 0

enemy.screen_width = love.graphics.getWidth()
enemy.screen_height = love.graphics.getHeight()

function enemy.load()
    enemy_damage = love.audio.newSource("assets/enemy_damage.mp3", "static")
    enemy_damage:setVolume(0.2)

    damage = love.audio.newSource("assets/player_damage.mp3", "static")
    damage:setVolume(0.2)

    enemy.sprite1 = love.graphics.newImage("assets/enemy1.png")
    enemy.sprite2 = love.graphics.newImage("assets/enemy2.png")

    love.math.setRandomSeed(os.time() + os.clock() * 100000)
end

function enemy.reset()
    enemy.list = {}
    espera = 2
    time_nascimento = 0
end

local function checkCollision(ax, ay, aw, ah, bx, by, bw, bh)
    return ax < bx + bw and bx < ax + aw and ay < by + bh and by < ay + ah
end

function enemy.criar_enemy()
    local minX = 0
    local maxX = enemy.screen_width - 50

    if love.math.random() >= 0.75 then
        table.insert(enemy.list, {
            y = -30,
            x = love.math.random(minX, maxX),
            tipo = 2,
            pontuacao = 20,
            speed = 80,
            hp = 3,
            width = enemy.sprite2:getWidth() * 0.2,
            height = enemy.sprite2:getHeight() * 0.15,
        })
    else
        table.insert(enemy.list, {
            y = -30,
            x = love.math.random(minX, maxX),
            tipo = 1,
            pontuacao = 10,
            speed = 200,
            hp = 1,
            width = enemy.sprite1:getWidth() * 0.6,
            height = enemy.sprite1:getHeight() * 0.2,
        })
    end
end

function enemy.update(dt)
    -- Movimento dos inimigos
    for _, e in ipairs(enemy.list) do
        e.y = e.y + e.speed * dt
    end

    -- Spawn dos inimigos
    time_nascimento = time_nascimento + dt
    if time_nascimento >= espera then
        espera = math.max(0.6, espera - 0.1) -- Aumenta a frequência dos inimigos
        time_nascimento = 0

        enemy.criar_enemy()
    end

    -- Colisão inimigo com jogador
    for i = #enemy.list, 1, -1 do
        local e = enemy.list[i]
        local playerX = player.x + 50
        local playerY = player.y
        local playerW, playerH = 60, 60

        if checkCollision(e.x, e.y, e.width, e.height, playerX, playerY, playerW, playerH) then
            if e.tipo == 1 or e.tipo == 2 then
                player.pontuacao_final = player.pontuacao_final + e.pontuacao
                local snd = enemy_damage:clone()
                snd:seek(0.5)
                snd:play()
                table.remove(enemy.list, i)
            end
        elseif e.y >= enemy.screen_height then
            player.hp = player.hp - 1
            local snd = damage:clone()
            snd:seek(0.5)
            snd:play()
            table.remove(enemy.list, i)
        end
    end

    -- Colisão inimigo com balas
    for i = #enemy.list, 1, -1 do
        local e = enemy.list[i]
        local enemyRemoved = false

        for j = #player.bullets, 1, -1 do
            local b = player.bullets[j]
            local bulletW, bulletH = 10, 20

            if checkCollision(b.x + 30, b.y, bulletW, bulletH, e.x, e.y, e.width, e.height) then
                e.hp = e.hp - 1
                table.remove(player.bullets, j)

                if e.hp <= 0 then
                    player.pontuacao_final = player.pontuacao_final + e.pontuacao
                    local snd = enemy_damage:clone()
                    snd:seek(0.5)
                    snd:play()
                    table.remove(enemy.list, i)
                    enemyRemoved = true
                end

                break
            end
        end

        if enemyRemoved then
            break
        end
    end
end

function enemy.draw()
    for _, e in ipairs(enemy.list) do
        if e.tipo == 1 then
            love.graphics.draw(enemy.sprite1, e.x, e.y, 0, 0.5, 0.3)
        elseif e.tipo == 2 then
            love.graphics.draw(enemy.sprite2, e.x, e.y, 0, 0.15, 0.15)
        end
    end
end

function enemy.resize(w, h)
    enemy.screen_width = w
    enemy.screen_height = h
end

return enemy

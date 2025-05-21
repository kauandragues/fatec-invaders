player = require("source.player")
local shot = 0
local time_nascimento = 0;
local espera = 2;
local dy = 1;
local screen_width, screen_height, flags = love.window.getMode()
local enemy = {}
enemy.sprite = nil
enemy.list = {}

function enemy.load(linguagem)
    enemy.sprite = love.graphics.newImage("assets/enemy.png")
    math.randomseed(os.time() + os.clock() * 100000)
    
end

function enemy.update(dt, player)
    -- Movimento dos inimigos
    for _, e in ipairs(enemy.list) do
        e.y = e.y + (e.speed) * dt
    end

    -- Spawn de inimigos
    time_nascimento = time_nascimento + 0.01
    if time_nascimento >= espera then
        espera = espera * 0.95
        dy = dy + 0.3
        if espera > 0.7 then espera = 1 end
        if dy > 3 then dy = 3 end
        time_nascimento = 0
        criar_enemy(dt, player)
    end

    -- Colisão inimigo vs jogador
    for i = #enemy.list, 1, -1 do
        local e = enemy.list[i]
        if math.abs(e.x - (player.x+50)) < 60 and math.abs(e.y - player.y) < 60 then
            table.remove(enemy.list, i)
        end
        if e.y >= 460 then
            player.hp = player.hp - 1;
            table.remove(enemy.list, i)
        end
    end

    -- Colisão inimigo vs balas
    for i = #enemy.list, 1, -1 do
        local e = enemy.list[i]
        for j = #player.bullets, 1, -1 do
            local b = player.bullets[j]
            if math.abs(b.x - e.x) < 20 and math.abs(b.y - e.y) < 20 then
                e.hp = e.hp - 1
                table.remove(player.bullets, j)
                if e.hp <= 0 then
                    table.remove(enemy.list, i)
                end
                break
            end
        end
    end
end

function enemy.draw()
    for _, e in ipairs(enemy.list) do
        love.graphics.draw(enemy.sprite, e.x, e.y, 0, 0.1, 0.1)
    end
end

function criar_enemy(dt, player)
    table.insert(enemy.list, {
        x = math.random(player.x-50, player.x+100),
        y = -30,
        speed = 200*dy,
        hp = 1
    })
end

return enemy
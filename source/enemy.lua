player = require("source.player")
local shot = 0
time_nascimento = 0;
antFarm = 1
espera = 1;
local screen_width, screen_height, flags = love.window.getMode()
local enemy = {}
enemy.sprite1 = nil
enemy.sprite2 = nil
enemy.list = {}
enemy.tipo = 1;

function enemy.load(linguagem)
    enemy.sprite1 = love.graphics.newImage("assets/enemy1.png")
    enemy.sprite2 = love.graphics.newImage("assets/enemy2.png")
    math.randomseed(os.time() + os.clock() * 100000)
end

function enemy.criar_enemy(dt)
    antFarm = antFarm + 0.005

    local minX, maxX

    -- Inimigo tipo 2 (grande)
    if math.random() >= 0.75 then
        minX = math.max(0, player.x - 100)
        maxX = math.min(screen_width - 50, player.x + 250) -- 50 é tamanho aproximado do inimigo

        table.insert(enemy.list, {
            y = -30,
            x = math.random(minX, maxX),
            tipo = 2,
            pontuacao = 20,
            speed = 80,
            hp = 3
        })
    -- Inimigo tipo 1 (pequeno)
    else
        minX = math.max(0, player.x - 70)
        maxX = math.min(screen_width - 50, player.x + 180)

        table.insert(enemy.list, {
            y = -30,
            x = math.random(minX, maxX),
            tipo = 1,
            pontuacao = 10,
            speed = 200,
            hp = 1
        })
    end
end

function enemy.update(dt)
    -- Movimento dos inimigos
    for _, e in ipairs(enemy.list) do
        e.y = e.y + (e.speed) * dt
    end

    -- Spawn de inimigos
    time_nascimento = time_nascimento + 0.01
    if time_nascimento >= espera then
        espera = espera - 0.005
        if espera <= 0.4 then espera = 0.4 end
        time_nascimento = 0
        enemy.criar_enemy(dt)
    end

    -- Colisão inimigo vs jogador
    for i = #enemy.list, 1, -1 do
        local e = enemy.list[i]
        if math.abs(e.x - (player.x+50)) < 60 and math.abs(e.y - player.y) < 60 and e.tipo == 1 then
            player.pontuacao_final = player.pontuacao_final + e.pontuacao
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
            if math.abs((b.x+30) - (e.x+30)) < 60 and math.abs(b.y - e.y) < 50 and e.tipo == 2 then
                e.hp = e.hp - 1
                table.remove(player.bullets, j)
                if e.hp <= 0 then
                    player.pontuacao_final = player.pontuacao_final + e.pontuacao
                    table.remove(enemy.list, i)
                end
                break
            end
        end
    end
end

function enemy.draw()
    for _, e in ipairs(enemy.list) do
        if e.tipo == 1 then
            love.graphics.draw(enemy.sprite1, e.x, e.y, 0, 0.2, 0.2)
        elseif e.tipo == 2 then
            love.graphics.draw(enemy.sprite2, e.x, e.y, 0, 0.1, 0.1)
        end
    end
end

return enemy
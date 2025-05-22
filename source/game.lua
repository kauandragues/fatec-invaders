player = require("source.player")
enemy = require("source.enemy")
missionStart = require("source.missionStart")
powerUp = require("source.powerUp")
local inicio_enemy = 2;
local espera = 0

local game = {}
local tempoSpawnPowerUp = 0
local intervaloSpawnPowerUp = 8
local time = 0
local estado = "jogando"
local screen_width, screen_height = 800, 600

function game.init(width, height)
    player.init(width, height)
    missionStart.init(width, height)
    screen_width = width
    screen_height = height
end

function game.load()
    enemy.load()
    player.load()
    missionStart.load()
    powerUp.load()

    math.randomseed(os.time() + os.clock() * 100000)

    love.window.setTitle("Quadrado Móvel")
end

function game.update(dt)
    if estado == "jogando" then
        tempoSpawnPowerUp = tempoSpawnPowerUp + dt
        if tempoSpawnPowerUp >= intervaloSpawnPowerUp then
            tempoSpawnPowerUp = 0
            powerUp.spawn()
        end
        powerUp.update(dt)
        player.update(dt)
        missionStart.update(dt)

        enemy.update(dt, player)

        if player.hp <= 0 then
            estado = "gameover"
        end

        time = time + dt

    elseif estado == "gameover" then
        if love.keyboard.isDown("r") then
            reiniciarJogo()
        end
    end
end

function game.draw()
    if estado == "jogando" then
        love.graphics.setColor(1, 1, 1)

        player.draw()
        missionStart.draw()
        powerUp.draw()

        if time >= inicio_enemy then
            enemy.draw()
        end
        love.graphics.setColor(1,1,1)
        love.graphics.printf("Pontuação: " .. player.pontuacao_final, 0 , 50,200, "center")

    elseif estado == "gameover" then
        love.graphics.setColor(1, 0, 0)
        love.graphics.printf("GAME OVER", 0, screen_height / 2 - 50, screen_width, "center")

    end
end

function reiniciarJogo()
    time = 0
    estado = "jogando"
    player.hp = 3
    player.x = 300
    player.y = 300
    enemy.list = {}
    enemy.time_nascimento = 0;
    enemy.espera = 2;
    enemy.dy = 1;
    player.pontuacao = 0
    missionStart.load()
end

return game
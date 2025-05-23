local start_screen = require("source.start_screen")
local player = require("source.player")
enemy = require("source.enemy")
local missionStart = require("source.missionStart")
local powerUp = require("source.powerUp")

local game = {}
local tempoSpawnPowerUp = 0
local intervaloSpawnPowerUp = 8
local time = 0
local inicio_enemy = 2

game.screen_width = love.graphics.getWidth()
game.screen_height = love.graphics.getHeight()

local pontuacaoParaVitoria = 1000

local gameover
local vitoria

game.estado = "jogando"

function game.init(width, height)
    game.screen_width = width
    game.screen_height = height

    player.init(width, height)
    missionStart.init(width, height)
    start_screen.init(width, height)
end

function game.resize(w, h)
    game.screen_width = w
    game.screen_height = h

    player.resize(w, h)
    missionStart.resize(w, h)
    start_screen.resize(w, h)
    enemy.resize(w, h)
end

function game.load()
    enemy.load()
    player.load()
    missionStart.load()
    powerUp.load()

    gameover = love.audio.newSource("assets/gameover.mp3", "static")
    gameover:setVolume(0.2)

    vitoria = love.audio.newSource("assets/vitoria.mp3", "static")
    vitoria:setVolume(0.2)
end

function game.update(dt)
    if game.estado == "jogando" then
        tempoSpawnPowerUp = tempoSpawnPowerUp + dt
        if tempoSpawnPowerUp >= intervaloSpawnPowerUp then
            tempoSpawnPowerUp = 0
            powerUp.spawn()
        end

        powerUp.update(dt)
        player.update(dt)
        missionStart.update(dt)
        enemy.update(dt)

        if player.hp <= 0 then
            game.estado = "gameover"
            musicaFundo:pause()
            gameover:play()
        elseif player.pontuacao_final >= pontuacaoParaVitoria then
            game.estado = "vitoria"
            musicaFundo:pause()
            vitoria:play()
        end

        time = time + dt

    elseif game.estado == "gameover" or game.estado == "vitoria" then
        if love.keyboard.isDown("r") then
            game:reiniciarJogo()
        end
    end
end

function game.draw()
    if game.estado == "jogando" then
        player.draw()
        missionStart.draw()
        powerUp.draw()

        if time >= inicio_enemy then
            enemy.draw()
        end

        love.graphics.setColor(173/255,216/255, 230/255)
        love.graphics.printf("Pontuação: " .. player.pontuacao_final, 20, 50, 200, "left")
        love.graphics.printf("Faça 1000 pontos!!", 20, 80, 200, "left")

    elseif game.estado == "gameover" then
        love.graphics.setColor(1, 0, 0)
        love.graphics.printf("GAME OVER", 0, game.screen_height / 2 - 50, game.screen_width, "center")
        love.graphics.printf("Sua pontuação final: " .. player.pontuacao_final, 0, game.screen_height / 2, game.screen_width, "center")
        love.graphics.printf("Pressione R para jogar novamente", 0, game.screen_height / 2 + 50, game.screen_width, "center")

    elseif game.estado == "vitoria" then
        love.graphics.setColor(0, 1, 0)
        love.graphics.printf("PARABÉNS! VOCÊ VENCEU!", 0, game.screen_height / 2 - 50, game.screen_width, "center")
        love.graphics.printf("Pressione R para jogar novamente", 0, game.screen_height / 2 + 50, game.screen_width, "center")
    end

    love.graphics.setColor(1, 1, 1) -- Resetando cor
end

function game:reiniciarJogo()
    -- Sons
    gameover:stop()
    vitoria:stop()
    musicaFundo:play()

    -- Resetando variáveis
    time = 0
    game.estado = "jogando"
    player.hp = 3
    player.x = game.screen_width / 2 - 30
    player.y = game.screen_height - 100
    enemy.list = {}
    enemy.reset()
    player.bullets = {}
    powerUp.lista = {}
    tempoSpawnPowerUp = 0
    player.pontuacao_final = 0

    -- Reiniciando estados
    missionStart.restart()
    start_screen.current_state = "start"
end

return game

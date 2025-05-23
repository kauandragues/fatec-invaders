local game = require("source.game")
local start_screen = require("source.start_screen")
local enemy = require("source.enemy")
local player = require("source.player")

local current_state = "start"
local backgroundVideo
local crosshair -- mira

function love.load()
    -- Música de fundo
    musicaFundo = love.audio.newSource("assets/backtrack.mp3", "stream")
    musicaFundo:setLooping(true)
    musicaFundo:setVolume(0.2)
    musicaFundo:play()

    click = love.audio.newSource("assets/click.wav", "static")
    click:setVolume(0.2)

    -- Fonte
    fonte = love.graphics.newFont(24)
    love.graphics.setFont(fonte)

    -- Tamanho da tela
    local screenWidth, screenHeight = love.graphics.getDimensions()

    -- Tela de início
    start_screen.init(screenWidth, screenHeight)
    start_screen.load()

    -- Vídeo de fundo
    backgroundVideo = love.graphics.newVideo("assets/background.ogv", { looping = true, audio = false })
    backgroundVideo:play()

    -- Jogo
    game.init(screenWidth, screenHeight)
    game.load()

    -- Carrega a mira e esconde o cursor padrão
    crosshair = love.graphics.newImage("assets/mira.png")
    love.mouse.setVisible(false)
end

function love.update(dt)
    -- Atualiza vídeo
    if backgroundVideo then
        if not backgroundVideo:isPlaying() then
            backgroundVideo:play()
        elseif backgroundVideo:tell() >= 59 then
            backgroundVideo:seek(15)
        end
    end

    -- Controle de estado
    current_state = start_screen.current_state

    if current_state == "game" then
        game.update(dt)
    elseif current_state == "start" then
        start_screen.update(dt)
    end
end

function love.draw()
    -- Desenha vídeo de fundo
    if backgroundVideo then
        local scaleX = love.graphics.getWidth() / backgroundVideo:getWidth()
        local scaleY = love.graphics.getHeight() / backgroundVideo:getHeight()
        love.graphics.setColor(1, 1, 1, 0.2)
        love.graphics.draw(backgroundVideo, 0, 0, 0, scaleX, scaleY)
    end

    love.graphics.setColor(1, 1, 1)

    if current_state == "game" then
        game.draw()
    elseif current_state == "start" then
        start_screen.draw()
    end

    -- Desenha a mira no topo de tudo
    local mx, my = love.mouse.getPosition()
    love.graphics.draw(crosshair, mx, my, 0, 0.1, 0.1, crosshair:getWidth()/2, crosshair:getHeight()/2)
end

function love.mousepressed(x, y, button)
    if current_state == "start" then
        click:seek(0.2)
        click:play()
        start_screen.mousepressed(x, y, button)
    end
end

function love.keypressed(key)
    if false then
        local fullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not fullscreen, "desktop")
    end
 
end

function love.resize(w, h)
    player.resize(w, h)
    enemy.resize(w, h)
    start_screen.init(w, h) -- se tiver tela de início
    game.init(w, h) -- se tiver controle de estados
end
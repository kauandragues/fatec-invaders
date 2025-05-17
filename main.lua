local game = require("source.game")




function love.load()
    local screenWidth, screenHeight = love.graphics.getDimensions()
game.init( screenWidth, screenHeight)
    game.load()
end

function love.update(dt)
    game.update(dt)
end

function love.draw()
    game.draw()
end
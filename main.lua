local game = require("source.game")
local start_screen = require("source.start_screen")
local current_state
local backgroundVideo


function love.load()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    start_screen.load()
    start_screen.init(screenWidth, screenHeight)
    
     backgroundVideo = love.graphics.newVideo("assets/background.ogv", {
        looping = true,
        audio = false
    })
    backgroundVideo:play()
    game.init( screenWidth, screenHeight)
    game.load()
    

end

function love.update(dt)
    current_state = start_screen.current_state

     if backgroundVideo then
        if not backgroundVideo:isPlaying() then
            backgroundVideo:play()
        elseif backgroundVideo:tell() >= 59 then
            backgroundVideo:seek(15)
        end
    end
    if current_state == "game" then
        game.update(dt)
        
    elseif  current_state == "start" then
       start_screen.update(dt)
        
    end    

    
    
end

function love.mousepressed(x,y, btnType)
    start_screen.mousepressed(x,y,btnType)
end

function love.draw()
    
    if current_state == "game" then
        local scaleX = love.graphics.getWidth() / backgroundVideo:getWidth()
        local scaleY = love.graphics.getHeight() / backgroundVideo:getHeight()
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.draw(backgroundVideo, 0, 0, 0, scaleX, scaleY)
        
        love.graphics.setColor(1, 1, 1, 1)
        game.draw()
        
    elseif  current_state == "start" then
       start_screen.draw()
        
    end    

    
end
local game = require("source.game")
local start_screen = require("source.start_screen")
local current_state 


function love.load()
    local screenWidth, screenHeight = love.graphics.getDimensions()
    start_screen.load()
    start_screen.init(screenWidth, screenHeight)
    game.init( screenWidth, screenHeight)
    game.load()
    

end

function love.update(dt)
    current_state = start_screen.current_state
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
        game.draw()
        
    elseif  current_state == "start" then
       start_screen.draw() 
        
    end    

    
end
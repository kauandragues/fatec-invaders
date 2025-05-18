Button = require("source.Button")
local startButton
local start_screen = {}



--inicializador do start_screen para pegar as dimensões da tela
function start_screen.init(screen_width, screen_height)
    start_screen.screen_width = screen_width
    start_screen.screen_height = screen_height
end

function start_screen.load()
    start_screen.current_state = "start"
    startButton = Button:new(300,200,200,60, "Start", function ()
        start_screen.current_state = "game"
    end)


end

function start_screen.update(dt)
    
end

function start_screen.draw()
    startButton:draw()
end

function start_screen.mousepressed(x,y,btnType)
    startButton:mousepressed(x,y,btnType)
end

return start_screen
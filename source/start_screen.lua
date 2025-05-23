local Button = require("source.Button")
local startButton
local start_screen = {}
local screen_width, screen_height = love.graphics.getDimensions()

function start_screen.init(screen_width, screen_height)
    start_screen.screen_width = screen_width
    start_screen.screen_height = screen_height
end

function start_screen.resize(w, h)
    start_screen.screen_width = w
    start_screen.screen_height = h

    -- Atualiza a posição do botão na tela nova
    if startButton then
        startButton.x = (w / 2) - (startButton.width / 2)
        startButton.y = (h / 2) - (startButton.height / 2)
    end
end

function start_screen.load()
    start_screen.current_state = "start"

    local btnWidth = 200
    local btnHeight = 60
    local btnX = (start_screen.screen_width / 2) - (btnWidth / 2)
    local btnY = (start_screen.screen_height / 2) - (btnHeight / 2)

    startButton = Button:new(btnX, btnY, btnWidth, btnHeight, "Start", function()
        start_screen.current_state = "game"
    end)
end

function start_screen.update(dt)
    local mx, my = love.mouse.getPosition()
    if startButton then
        startButton:update(mx, my)
    end
end

function start_screen.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("SPACE INVADERS FATEC", 0, start_screen.screen_height / 4, start_screen.screen_width, "center")
    if startButton then
        startButton:draw()
    end
end

function start_screen.mousepressed(x, y, btnType)
    if startButton then
        startButton:mousepressed(x, y, btnType)
    end
end

return start_screen
Bullet = require("source.bullet")
local shot = 0
bullets = {}

local player = {
    x = 100,
    y = 100,
    speed = 200,
    spriteSheet = nil,
    quads = {},       -- lista dos quadros (frames)
    currentFrame = 1,
    frameWidth = 512,  -- largura de cada frame no sprite sheet
    frameHeight = 512, -- altura de cada frame
    frameCount = 3,   -- número total de frames
    timePerFrame = 0.15, -- tempo que cada frame fica na tela
    timer = 0
}


function player.init(screen_width, screen_height)
    player.x = (screen_width - player.frameWidth * 0.3)/ 2
    player.y = (screen_height - player.frameHeight * 0.2) / 2
    
end

function player.load()
    player.spriteSheet = love.graphics.newImage("assets/player.png")

    for i = 0, player.frameCount - 1 do
        table.insert(player.quads, 
            love.graphics.newQuad(
                i * player.frameWidth, 0,
                player.frameWidth, player.frameHeight,
                player.spriteSheet:getDimensions()
            )
        )
    end
end

function player.update(dt)
    -- Atualiza timer para troca de frame
    player.timer = player.timer + dt
    if player.timer >= player.timePerFrame then
        player.timer = player.timer - player.timePerFrame
        player.currentFrame = player.currentFrame + 1
        if player.currentFrame > player.frameCount then
            player.currentFrame = 1
        end
    end
    if love.keyboard.isDown("z") then
        if shot == 0 then
            table.insert(bullets, Bullet:new(player.x + 74, player.y, 0, -1, 300))
            shot = true
            shot = 10
        end
        shot = shot -1 
        
    end

    -- Movimento do player (igual antes)
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
    elseif love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed * dt
    elseif love.keyboard.isDown("up") then
        player.y = player.y - player.speed * dt
    end
    for _, bullet in ipairs(bullets) do 
        bullet:update(dt)
    end    
end

function player.draw()
    love.graphics.draw(
        player.spriteSheet, 
        player.quads[player.currentFrame], 
        player.x, 
        player.y,
        0, 
        0.3,
        0.2
    )

    for _, bullet in ipairs(bullets) do
        bullet:draw()
    end

end

return player
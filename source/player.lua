Bullet = require("source.bullet")
local shot = 0
bullets = {}
local screen_width, screen_height, flags = love.window.getMode()

local player = {
    x = 100,
    y = 100,
    speed = 200,
    spriteSheet = nil,
    hp = 3;
}


function player.init(screen_width, screen_height)
    player.x = (screen_width - player.x * 0.3)/ 2
    player.y = (screen_height - player.y * 0.2) / 2
    
end

function player.load()
    player.spriteSheet = love.graphics.newImage("assets/player.png")
end

function player.update(dt)
    if love.keyboard.isDown("z") then
        if shot == 0 then
            table.insert(bullets, Bullet:new(player.x + 74, player.y, 0, -1, 300))
            shot = true
            shot = 10
        end
        shot = shot -1 
        
    end

    -- Movimento do player (igual antes)

    if love.keyboard.isDown("right") and player.x < screen_width-130 then
        player.x = player.x + player.speed * dt
    elseif love.keyboard.isDown("left") and player.x > -28 then
        player.x = player.x - player.speed * dt
    end

    if love.keyboard.isDown("down") and player.y < screen_height-112 then
        player.y = player.y + player.speed * dt
    elseif love.keyboard.isDown("up") and player.y > -9 then
        player.y = player.y - player.speed * dt
    end
    for i, bullet in ipairs(bullets) do 
        bullet:update(dt)
        if bullet.y < -10 then

            table.remove(bullets, i)
        end    
    end    
end

function player.draw()
    love.graphics.draw(player.spriteSheet, player.x, player.y, 0, 0.1, 0.1
    )

    for _, bullet in ipairs(bullets) do
        bullet:draw()
    end

end

return player
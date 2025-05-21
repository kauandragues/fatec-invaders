Bullet = require("source.bullet")
local shot = 0
bullets = {}
local screen_width, screen_height, flags = love.window.getMode()

local player = {
    x = 100,
    y = 100,
    speed = 300,
    sprite = nil,
    base_monitor1,
    base_monitor2,
    base_monitor3,
    hp = 3,
    bullets = {}, 
    linguagem = "lua",
    pontuacao_final = 0
}


function player.init(screen_width, screen_height)
    player.screen_width = screen_width or love.graphics.getWidth()
    player.screen_height = screen_height or love.graphics.getHeight()
    player.linguagem="lua"
    player.x = 300
    player.y = 300
    
end

function player.load()
    player.sprite = love.graphics.newImage("assets/player.png")
    player.base_monitor = love.graphics.newImage("assets/monitores.png")
    player.spriteLua = love.graphics.newImage("assets/playerLua.png")
    player.spriteC = love.graphics.newImage("assets/playerC.png")
    player.spritePython = love.graphics.newImage("assets/playerPython.png")
end

function player.update(dt)
    if player.linguagem == "lua" then
        playerLua(dt)
    elseif player.linguagem == "C" then
        playerC(dt)
    elseif player.linguagem == "Python" then
        playerPython(dt)
    end
end

function playerPython(dt)

end

function playerC(dt)

end

function playerLua(dt)
    player.speed = 400
    if love.keyboard.isDown("z") then
        if shot == 0 then
            table.insert(player.bullets, Bullet:new(player.x + 74, player.y, 0, -1, 300))
            shot = 10
        end
        shot = shot - 1
    end

    for i = #player.bullets, 1, -1 do
        local bullet = player.bullets[i]
        bullet:update(dt)
        if bullet.y < -10 then
            table.remove(player.bullets, i)
        end
    end

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
end

function player.draw()
    local current_sprite
    if player.linguagem == "lua" then
        current_sprite = player.spriteLua
    elseif player.linguagem == "C" then
        current_sprite = player.spriteC
    elseif player.linguagem == "Python" then
        current_sprite = player.spritePython
    end

    if player.hp == 3 then
        love.graphics.draw(current_sprite, player.x, player.y, 0, 0.1, 0.1)
        love.graphics.draw(player.sprite, 280, 420, 0, 0.07, 0.07)
        love.graphics.draw(player.base_monitor, 90, 460, 0, 0.3, 0.3)
        love.graphics.draw(player.base_monitor, 520, 460, 0, 0.3, 0.3)
    elseif player.hp == 2 then 
        love.graphics.draw(current_sprite, player.x, player.y, 0, 0.1, 0.1)
        love.graphics.draw(player.sprite, 280, 420, 0, 0.07, 0.07)
        love.graphics.draw(player.base_monitor, 90, 460, 0, 0.3, 0.3)
    elseif player.hp == 1 then
        love.graphics.draw(current_sprite, player.x, player.y, 0, 0.1, 0.1)
        love.graphics.draw(player.sprite, 280, 420, 0, 0.07, 0.07)
    end

    if player.hp == 3 then
        love.graphics.draw(current_sprite, player.x, player.y, 0, 0.1, 0.1)
        love.graphics.draw(player.sprite, 280, 420, 0, 0.07, 0.07)
        love.graphics.draw(player.base_monitor, 90, 460, 0, 0.3, 0.3)
        love.graphics.draw(player.base_monitor, 520, 460, 0, 0.3, 0.3)
    elseif player.hp == 2 then 
        love.graphics.draw(current_sprite, player.x, player.y, 0, 0.1, 0.1)
        love.graphics.draw(player.sprite, 280, 420, 0, 0.07, 0.07)
        love.graphics.draw(player.base_monitor, 90, 460, 0, 0.3, 0.3)
    elseif player.hp == 1 then
        love.graphics.draw(current_sprite, player.x, player.y, 0, 0.1, 0.1)
        love.graphics.draw(player.sprite, 280, 420, 0, 0.07, 0.07)
    end

    for _, bullet in ipairs(player.bullets) do
        bullet:draw()
    end

end

return player
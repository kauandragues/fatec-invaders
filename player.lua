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
end

return player
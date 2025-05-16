local player = {
    --colocar um sprite aqui mais tarde
    x = 100,
    y = 100,
    speed = 200,
    size = 50
}

function player.update(dt)
    --ver se o player está pressionando alguma dessas teclas
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
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
end

return player
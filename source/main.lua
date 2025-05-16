-- main.lua

local time = 0
local stars = {}

local player = {
    x = 100,
    y = 100,
    speed = 200,
    size = 50
}

function love.load()
    math.randomseed(os.time() + os.clock() * 100000)
    
    love.window.setTitle("Quadrado Móvel")
    

    for i = 1, 200 do
        table.insert(stars, {
            x = math.random() * 800,
            y = math.random(0,800),
            speed = math.random(20,100)

        })
    end    
end

function love.update(dt)
    
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

    for _, star in ipairs(stars) do 
        star.y = star.y + star.speed *dt

        if star.y > 600 then
            star. y = 0
            star.x = math.random() * 800
        end
    end    

    time = time +dt
    

end

     

function love.draw()
    
    love.graphics.setColor(1,1,1)
    for _, star in ipairs(stars) do
        love.graphics.rectangle("fill", star.x, star.y, 2, 2)
    end
    
    love.graphics.setColor(1, 0, 0) -- vermelho
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
    
    time = time + 1
end

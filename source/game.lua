local player = require("source.player")
local enemy = require("source.enemy")
local missionStart = require("source.missionStart")
local inicio_enemy = 2;

local game = {}

local time = 0
local stars = {}
local estado = "jogando"
local screen_width, screen_height = 800, 600

function game.init(width, height)
    player.init(width, height)
    missionStart.init(width, height)
    screen_width = width
    screen_height = height
end

function game.load()
    enemy.load()
    player.load()
    missionStart.load()

    math.randomseed(os.time() + os.clock() * 100000)

    love.window.setTitle("Quadrado Móvel")

    for i = 1, 200 do
        table.insert(stars, {
            x = math.random() * 800,
            y = math.random(0, 800),
            speed = math.random(20, 100)
        })
    end
end

function game.update(dt)
    if estado == "jogando" then
        player.update(dt)
        missionStart.update(dt)

        if time >= inicio_enemy then
            enemy.update(dt, player)
        end

        if player.hp <= 0 then
            estado = "gameover"
        end

        for _, star in ipairs(stars) do
            star.y = star.y + star.speed * dt
            if star.y > 600 then
                star.y = 0
                star.x = math.random() * 800
            end
        end    

        time = time + dt

    elseif estado == "gameover" then
        if love.keyboard.isDown("r") then
            reiniciarJogo()
        end
    end
end

function game.draw()
    if estado == "jogando" then
        love.graphics.setColor(1, 1, 1)
        for _, star in ipairs(stars) do
            love.graphics.rectangle("fill", star.x, star.y, 2, 2)
        end

        player.draw()
        missionStart.draw()

        if time >= inicio_enemy then
            enemy.draw()
        end

    elseif estado == "gameover" then
        love.graphics.setColor(1, 0, 0)
        love.graphics.printf("GAME OVER", 0, screen_height / 2 - 50, screen_width, "center")

    end
end

function reiniciarJogo()
    time = 0
    estado = "jogando"
    player.hp = 3
    player.x = screen_width / 2
    player.y = screen_height - 100
    enemy.list = {}
    missionStart.load()
end

return game
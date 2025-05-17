local player = require("source.player")

local missionStart = require("source.missionStart")


local game = {}

local time = 0
local stars = {}

function game.init( width, height)
    player.init(width,height)
    missionStart.init( width, height)
end

function game.load()
    
    player.load();
    missionStart.load()
    --serve para criar um num aleatorio msm kk
    math.randomseed(os.time() + os.clock() * 100000)
    
    love.window.setTitle("Quadrado Móvel")

    --cria 200 estrelas diferentes com posições,  e velocidades aleatorias
    for i = 1, 200 do
        table.insert(stars, {
            x = math.random() * 800,
            y = math.random(0,800),
            speed = math.random(20,100)
        })
    end
end

function game.update(dt)

    player.update(dt)
    missionStart.update(dt)

    -- movimenta cada estrela
    for _, star in ipairs(stars) do 
        star.y = star.y + star.speed * dt

        --retorna a estrela pro começo se ela chegar no final
        --mas dá uma valor aleatorio para o x
        if star.y > 600 then
            star.y = 0
            star.x = math.random() * 800
        end
    end    

    time = time + dt
end

function game.draw()

    --mostra cada uma das 200 estrelas
    love.graphics.setColor(1, 1, 1)
    for _, star in ipairs(stars) do
        love.graphics.rectangle("fill", star.x, star.y, 2, 2)
    end

    player.draw()
    missionStart.draw()
    
    time = time + 1
end

return game
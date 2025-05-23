local MissionStart = {}

MissionStart.time = 0
MissionStart.displayDuration = 2
MissionStart.finishedCallback = nil

function MissionStart.init(width, height, onFinish)
    MissionStart.height = height
    MissionStart.width = width
    MissionStart.finishedCallback = onFinish or nil
end

function MissionStart.resize(w, h)
    MissionStart.width = w
    MissionStart.height = h
    MissionStart.rectWidth = MissionStart.width * 0.35
    MissionStart.targetX = MissionStart.width / 2
end

function MissionStart.load()
    MissionStart.text_sprite = love.graphics.newImage("assets/game_start.png")

    MissionStart.rectWidth = MissionStart.width * 0.35
    MissionStart.rectSpeed = 300

    MissionStart.targetX = MissionStart.width / 2

    MissionStart.leftX = -MissionStart.rectWidth
    MissionStart.rightX = MissionStart.width

    MissionStart.show = true
    MissionStart.time = 0
end

function MissionStart.restart()
    MissionStart.leftX = -MissionStart.rectWidth
    MissionStart.rightX = MissionStart.width
    MissionStart.show = true
    MissionStart.time = 0
end

function MissionStart.update(dt)
    if MissionStart.show then
        MissionStart.time = MissionStart.time + dt

        MissionStart.leftX = math.min(MissionStart.leftX + MissionStart.rectSpeed * dt, MissionStart.targetX - MissionStart.rectWidth)
        MissionStart.rightX = math.max(MissionStart.rightX - MissionStart.rectSpeed * dt, MissionStart.targetX)

        if MissionStart.time > MissionStart.displayDuration then
            MissionStart.show = false
            if MissionStart.finishedCallback then
                MissionStart.finishedCallback()
            end
        end
    end
end

function MissionStart.draw()
    if MissionStart.show then
        -- Desenhar os retângulos azuis
        love.graphics.setColor(173/255, 216/255, 230/255)
        local rectY = (MissionStart.height - 100) / 2
        love.graphics.rectangle("fill", MissionStart.leftX, rectY, MissionStart.rectWidth, 100)
        love.graphics.rectangle("fill", MissionStart.rightX, rectY, MissionStart.rectWidth, 100)

        -- Desenhar o texto se os retângulos chegaram no meio
        if MissionStart.leftX >= MissionStart.targetX - MissionStart.rectWidth and 
           MissionStart.rightX <= MissionStart.targetX then

            local scale = 0.20
            local spriteWidth = MissionStart.text_sprite:getWidth() * scale
            local spriteHeight = MissionStart.text_sprite:getHeight() * scale
            local spriteX = (MissionStart.width - spriteWidth) / 2
            local spriteY = (MissionStart.height - spriteHeight) / 2

            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(MissionStart.text_sprite, spriteX, spriteY, 0, scale, scale)
        end

        love.graphics.setColor(1, 1, 1) -- Resetar cor
    end
end

return MissionStart

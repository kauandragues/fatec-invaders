-- "Animação" de inicialização de partida 

local MissionStart = {}
local time = 0

--construtor / inicializador do MissionStart que pega a largura e o tamanho da tela do jogo
function  MissionStart.init( width, height)
    MissionStart.height = height
    MissionStart.width = width
    
end

function MissionStart.load()
    
    --Pegando o texto em game_start.png
    MissionStart.text_sprite = love.graphics.newImage("assets/game_start.png")

    --definindo tamanho e outras propriedades dos retangulos de fundo da "animação" -> Talvez deveria ter feito um obj
    MissionStart.rectWidth = MissionStart.width * 0.35
    MissionStart.rectSpeed = 300
    MissionStart.targetX = MissionStart.width / 2

    MissionStart.leftX = -MissionStart.rectWidth
    MissionStart.rightX = MissionStart.width

    --Boolean que diz se uma partida está no estado inicial
    MissionStart.show = true
end

function MissionStart.update(dt)
    --Contador de tempo que define a duração do estado inicial de uma partida, e assim o tempo da "animação"
    time = time + dt

    --Definição da posição dos retangulos, que mudam com o tempo, assim causando a "animação"
    if MissionStart.show then
        MissionStart.leftX = math.min(MissionStart.leftX + MissionStart.rectSpeed * dt, MissionStart.targetX - MissionStart.rectWidth )
        MissionStart.rightX = math.max(MissionStart.rightX - MissionStart.rectSpeed * dt, MissionStart.targetX )
        
 
    end
end

function MissionStart.draw()
    --Definindo cores dos tringulos e desenhando eles
    
    if MissionStart.show then
        love.graphics.setColor(173/255,216/255, 230/255)
        love.graphics.rectangle("fill", MissionStart.leftX, (MissionStart.height - 100) / 2, MissionStart.rectWidth, 100)
        love.graphics.rectangle("fill", MissionStart.rightX, (MissionStart.height- 100) / 2, MissionStart.rectWidth, 100)

        if MissionStart.leftX >= MissionStart.targetX - MissionStart.rectWidth and MissionStart.rightX <= MissionStart.targetX  then
            love.graphics.draw(MissionStart.text_sprite,MissionStart.leftX - MissionStart.text_sprite:getWidth() * 0.01, (MissionStart.height - MissionStart.text_sprite:getHeight()* 0.22) / 2 , 0 , 0.20, 0.20)
            
        end
    end
    
    if time > 2 then
        MissionStart.show = false
    end
    
end

return MissionStart

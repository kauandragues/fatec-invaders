--Modulo de botão simples

local Button = {}

--Necessario para definir uma classe botão
Button.__index = Button

--Construtor do botão
function Button:new(x,y,width, height, txt, onClick)
    local btn = {
        x = x,
        y = y,
        width = width,
        height = height,
        txt = txt,
        onClick = onClick

    }
    --Definindo o objeto btn como pertencento a classe botão
    setmetatable(btn, Button)
    return btn
    
end


function Button:draw()
    love.graphics.setColor(0.2,0.6,1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(1,1,1)
    love.graphics.printf(self.txt, self.x, self.y+20, self.width, "center")
end

--Metodo que le o clique do mouse, checa se a posição do ponteiro é a mesma que a do botão durante o clique
function Button:mousepressed(x,y,btnType)
    if btnType == 1 and x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
        self.onClick()

    end 
end

return Button


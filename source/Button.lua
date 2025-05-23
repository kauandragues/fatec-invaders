local Button = {}
Button.__index = Button

function Button:new(x, y, width, height, txt, onClick, colors)
    local btn = {
        x = x,
        y = y,
        width = width,
        height = height,
        txt = txt,
        onClick = onClick,
        colors = colors or {
            normal = {0.2, 0.6, 1},
            hover = {0.1, 0.5, 0.9},
            text = {1, 1, 1}
        },
        isHover = false
    }
    setmetatable(btn, Button)
    return btn
end

function Button:update(mx, my)
    self.isHover = mx >= self.x and mx <= self.x + self.width and
                   my >= self.y and my <= self.y + self.height
end

function Button:draw()
    if self.isHover then
        love.graphics.setColor(self.colors.hover)
    else
        love.graphics.setColor(self.colors.normal)
    end

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(self.colors.text)
    local font = love.graphics.getFont()
    local textHeight = font:getHeight()
    local textY = self.y + (self.height - textHeight) / 2
    love.graphics.printf(self.txt, self.x, textY, self.width, "center")
end

function Button:mousepressed(x, y, btnType)
    if btnType == 1 and self.isHover then
        self.onClick()
    end
end

return Button

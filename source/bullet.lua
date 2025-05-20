-- source/bullet.lua
local Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, dx, dy, speed)
    local self = setmetatable({}, Bullet)
    self.x = x
    self.y = y
    self.dx = dx or 0
    self.dy = dy or -1
    self.speed = speed or 300
    self.width = 6
    self.height = 10
    self.damage = 10
    return self
end

function Bullet:update(dt)
    
    self.y = self.y + self.dy * self.speed * dt
end

function Bullet:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Bullet

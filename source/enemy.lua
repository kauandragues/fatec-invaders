-- source/bullet.lua
local En = {}
Enemy.__index = Enemy

function Enemy:new(x, y, dy, dx, speed, hp)
    local self = setmetatable({}, Enemy)
    self.x = x
    self.y = y
    self.dy = dy or -1
    self.dx = dx or 0;
    self.speed = speed or 300
    self.width = 6
    self.height = 10
    self.damage = 10
    return self
end

function Enemy:update(dt)
    
    self.y = self.y + self.dy * self.speed * dt
end

function Enemy:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Enemy

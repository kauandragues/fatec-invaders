Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, dx, dy, speed)
    self = setmetatable({}, Bullet)
    self.x = x
    self.y = y
    self.dx = dx or 0
    self.dy = dy or -1
    self.speed = speed or 300
    self.width = 6
    self.height = 10
    self.damage = 10
    self.sprite = love.graphics.newImage("assets/bullet.png")
    return self
end

function Bullet:update(dt)
    
    self.y = self.y + self.dy * self.speed * dt
end

function Bullet:draw()
    love.graphics.draw(self.sprite, self.x, self.y, 0, 0.08, 0.08)
end

return Bullet

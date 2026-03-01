Object = {x = 0, y = 0, vx = 0, vy = 0, ax = 0, ay = 0, size = 1}
function Object.new(x, y, vx, vy, ax, ay, size)
    return setmetatable({x = x, y = y, vx = vx, vy = vy, ax = ax, ay = ay, size = size}, {__index = Object})
end

function Object.collision(thing1, thing2)
    local delta_x = thing1.x - thing2.x
    local delta_y = thing1.y - thing2.y
    local R = thing1.size/2 + thing2.size/2
    return delta_x*delta_x + delta_y*delta_y <= R*R
end

Player = Object.new(365, 500, 0, 0, 0, 0, 50)
Player.hp = 100
Player.theta = -math.pi/2

function Player:draw()
    --love.graphics.polygon("line",
  --  {
       -- Player.x + Player.size/2 + math.cos(Player.theta)*(Player.size/2),
        --Player.y + Player.size/2 + math.sin(Player.theta)*(Player.size/2),
        --Player.x + Player.size/2 + math.cos(Player.theta + math.pi + math.pi/4)*(Player.size/2),
        --Player.y + Player.size/2 + math.sin(Player.theta + math.pi + math.pi/4)*(Player.size/2),
        --Player.x + Player.size/2,
        --Player.y + Player.size/2,
        --Player.x + Player.size/2 + math.cos(Player.theta + math.pi - math.pi/4)*(Player.size/2),
        --Player.y + Player.size/2 + math.sin(Player.theta + math.pi - math.pi/4)*(Player.size/2),
--})  
    local image = Image.get("rocket")
    love.graphics.draw(image, Player.x + Player.size/2, Player.y + Player.size/2, Player.theta + math.pi/2, 1, 1, Player.size/2, Player.size/2)
    
end
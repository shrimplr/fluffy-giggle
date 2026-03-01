function IntroUpdate(dt)
    
end

function IntroLoad()
    
end

function IntroMouse(x, y, b)
    
end

function IntroKey(k)
    if k == "space" then
        Game.State = 0.5
        PreGameLoad()
    end
    
end

function IntroDraw()
    love.graphics.print('Idonfuckinknow', 300, 250)
    love.graphics.print('Press space to start', 300, 350)
    
end

function PreGameLoad()
    Crosses = 0
    Player.x = 300
    Player.y = 500
    Player.theta = -math.pi/2
    Player.hp = 100
end

function PreGameUpdate(dt)
    Player.vx = 0
    Player.vy = 0

    local ThetaMultiplier = 0

    if love.keyboard.isDown("w") then
        Player.vx = math.cos(Player.theta)*Player.size
        Player.vy = math.sin(Player.theta)*Player.size
    end
    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
        Player.vx = Player.vx*5
        Player.vy = Player.vy*5
        ThetaMultiplier = math.pi/4
    end

    if love.keyboard.isDown("a") then
        Player.theta = Player.theta + ((math.pi/4) + ThetaMultiplier)*dt
    end
    if love.keyboard.isDown("d") then
        Player.theta = Player.theta - ((math.pi/4) + ThetaMultiplier)*dt
    end

    Player.x = Player.vx*dt + Player.x
    Player.y = Player.vy*dt + Player.y

    if Player.x + Player.size/2 > 800 then 
        Player.x = 800 - Player.size/2
    end
    if Player.y + Player.size/2 > 600 then
        Player.y = 600 - Player.size/2
    end
    if Player.x + Player.size/2 < 0 then
        Player.x = 0 - Player.size/2
    end
    if Player.y + Player.size/2 < 0 then
        Player.y = Player.y + 600 - Player.size/2
    Crosses = Crosses + 1
    end
    if Crosses >= 2 then
        GameLoad()
        Game.State = 1
    end

end

function PreGameDraw()
    local image
    if Crosses < 1 then image = Image.get("pregame1") end
    if Crosses >= 1 then image = Image.get("pregame2") end
    love.graphics.draw(image, 0, 0)

        love.graphics.polygon("line", {
        Player.x + Player.size/2 + math.cos(Player.theta)*(Player.size/2),
        Player.y + Player.size/2 + math.sin(Player.theta)*(Player.size/2),
        Player.x + Player.size/2 + math.cos(Player.theta + math.pi + math.pi/4)*(Player.size/2),
        Player.y + Player.size/2 + math.sin(Player.theta + math.pi + math.pi/4)*(Player.size/2),
        Player.x + Player.size/2,
        Player.y + Player.size/2,
        Player.x + Player.size/2 + math.cos(Player.theta + math.pi - math.pi/4)*(Player.size/2),
        Player.y + Player.size/2 + math.sin(Player.theta + math.pi - math.pi/4)*(Player.size/2),
})  
end

function GameUpdate(dt)
    Game.totaltime = Game.totaltime + dt

    Player.vx = 0
    Player.vy = 0

    local ThetaMultiplier = 0

    if love.keyboard.isDown("w") then
        Player.vx = math.cos(Player.theta)*Player.size
        Player.vy = math.sin(Player.theta)*Player.size
    end

    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
        Player.vx = Player.vx*5
        Player.vy = Player.vy*5
        ThetaMultiplier = math.pi/4
    end

    if love.keyboard.isDown("a") then
        Player.theta = Player.theta + ((math.pi/4) + ThetaMultiplier)*dt
    end
    if love.keyboard.isDown("d") then
        Player.theta = Player.theta - ((math.pi/4) + ThetaMultiplier)*dt
    end

    Player.x = Player.vx*dt + Player.x
    Player.y = Player.vy*dt + Player.y

    if Player.x + Player.size/2 > 800 then 
        Player.x = Player.x - 800 + Player.size/2
    end
    if Player.y + Player.size/2 > 600 then
        Player.y = Player.y - 600 + Player.size/2
    end
    if Player.x + Player.size/2 < 0 then
        Player.x = Player.x + 800 - Player.size/2
    end
    if Player.y + Player.size/2 < 0 then
        Player.y = Player.y + 600 - Player.size/2
    end

    for i, ast in pairs(Asteroids) do
        ast.x = ast.vx*dt + ast.x
        ast.y = ast.vy*dt + ast.y

        if ast.x + ast.size/2 > 800 then 
            ast.x = ast.x - 800 + ast.size/2
        end
        if ast.y + ast.size/2 > 600 then
            ast.y = ast.y - 600 + ast.size/2
        end
        if ast.x + ast.size/2 < 0 then
            ast.x = ast.x + 800 - ast.size/2
        end
        if ast.y + ast.size/2 < 0 then
            ast.y = ast.y + 600 - ast.size/2
        end

        if Object.collision(ast, Player) then
            if ast.size >= 20 and ast.size <= 40 then
                Player.hp = Player.hp - 10
            end
            if ast.size > 40 and ast.size <= 60 then
                 Player.hp = Player.hp - 25
            end
            if ast.size > 60 and ast.size <= 80 then
                Player.hp = Player.hp - 40
            end
            if ast.size > 80 and ast.size <= 100 then
                Player.hp = Player.hp - 55
            end
            Asteroids[i] = nil
        end
        if Player.hp <= 0 then
            Game.State = 2
        end
    end
end

function GameLoad()

    Asteroids = {}
    for i = 1, 7 do
        Asteroids[i] = Object.new(math.random(0, 800), math.random(0, 600), math.random(-100, 100), math.random(-100, 100), 0, 0, math.random(20, 100))
    end
end

function GameMouse(x, y, b)
    
end

function GameKey(k)

end

function GameDraw()
    local image = Image.get("space_bg")
    love.graphics.draw(image, 0, 0)

    love.graphics.polygon("line",
    {
        Player.x + Player.size/2 + math.cos(Player.theta)*(Player.size/2),
        Player.y + Player.size/2 + math.sin(Player.theta)*(Player.size/2),
        Player.x + Player.size/2 + math.cos(Player.theta + math.pi + math.pi/4)*(Player.size/2),
        Player.y + Player.size/2 + math.sin(Player.theta + math.pi + math.pi/4)*(Player.size/2),
        Player.x + Player.size/2,
        Player.y + Player.size/2,
        Player.x + Player.size/2 + math.cos(Player.theta + math.pi - math.pi/4)*(Player.size/2),
        Player.y + Player.size/2 + math.sin(Player.theta + math.pi - math.pi/4)*(Player.size/2),
})  

for i, ast in pairs(Asteroids) do
    love.graphics.circle("line", ast.x + ast.size/2, ast.y + ast.size/2, ast.size/2)
end

    love.graphics.print("HP: "..math.floor(Player.hp), 0, 0)
    love.graphics.print("Time: "..math.floor(Game.totaltime), 0, 15)

end
function OverDraw()
    love.graphics.print("*Dies*",300, 250)
    love.graphics.print("Press space to return", 300, 300)
    love.graphics.print("Total time: "..math.floor(Game.totaltime), 300, 350)
end

function OverKey(k)
    if k == "space" then
        Game.State = 0
    end
end
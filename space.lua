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
    --love.graphics.print('Idonfuckinknow', 300, 250)
    love.audio.play(introm)
    love.audio.setVolume(0.5)
    local image = Image.get("Ahh_bg")
    love.graphics.draw(image, 0, 0)
    love.graphics.setFont(NewFont)
    love.graphics.print('Press space to start', NewFont, 250, 300)
    
end

function PreGameLoad()
    Crosses = 0
    Player.x = 365
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
        love.audio.stop(introm)
        Game.State = 1
    end

end

function PreGameDraw()
    local image
    if Crosses < 1 then image = Image.get("pregame1") end
    if Crosses >= 1 then image = Image.get("pregame2") end
    love.graphics.draw(image, 0, 0)

        Player:draw()
end

function GameUpdate(dt)
    love.audio.play(bgm)
    love.audio.setVolume(0.3)
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
            love.audio.play(hit)
        end
        if Player.hp <= 0 then
            Game.State = 2
            love.audio.stop(bgm)
            love.audio.play(die)
            love.audio.setVolume(0.5)
        end
        if Game.totaltime >= 100 then
            Game.State = 3
            love.audio.stop(bgm)
            love.audio.play(win)
            love.audio.setVolume(0.5)
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

    Player:draw()

for i, ast in pairs(Asteroids) do
    --love.graphics.circle("line", ast.x + ast.size/2, ast.y + ast.size/2, ast.size/2)
    local image = Image.get("asteroid")
    love.graphics.draw(image, ast.x + (ast.size/60), ast.y + (ast.size/60) , 0, ast.size/60, ast.size/60)
end
    love.graphics.setFont(NewFont)
    love.graphics.print("HP: "..math.floor(Player.hp), 0, 0)
    love.graphics.print("Time: "..math.floor(Game.totaltime), 2, 17)

end

function OverDraw()
    love.graphics.setFont(NewFont)
    love.graphics.print("*Dies*",250, 250)
    love.graphics.print("Press space to return", 250, 300)
    love.graphics.print("Total time: "..math.floor(Game.totaltime), 250, 350)
end

function OverKey(k)
    if k == "space" then
        Game.State = 0
        love.audio.stop(die)
    end
end

function WinDraw()
    love.graphics.setFont(NewFont)
    love.graphics.print("Congrats, you didn't die!", 250, 300)
    love.graphics.print("Press space to return", 250, 350)
end
function WinKey(k)
    if k == "space" then
        Game.State = 0
        love.audio.stop(win)
    end
end
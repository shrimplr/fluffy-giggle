jit.off()
love.graphics.setDefaultFilter("nearest", "nearest")
require("globals")

function love.load()

end

function love.update(dt)
	local f = Update_State[Game.State]
	if f then
		f()
	end
end

function love.keypressed(key)
	local f = Keypressed_State[Game.State]
	if f then
		f()
	end
end

function love.mousepressed(key)
	local f = Mousepressed_State[Game.State]
	if f then
		f()
	end
end

function love.draw()
	Draw_Sfx()
	local f = Draw_State[Game.State]
	if f then
		f()
	end
end

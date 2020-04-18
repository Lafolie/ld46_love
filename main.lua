--[[
	MAIN ENTRY
]]

class = require "lib.class"
vector = require "lib.vector"

require "class.tilemap"
require "class.actor"

-- set scaling rules
love.graphics.setDefaultFilter("nearest", "nearest")

-- native canvas setup
local nativeWidth = 320;
local nativeHeight = 240;

local nativeCanvas = love.graphics.newCanvas(nativeWidth, nativeHeight)
local windowScale = 1;

function updateCanvasScale()
	local w, h = love.graphics.getDimensions()
	local scalex = w / nativeWidth
	local scaley = h / nativeHeight

	canvasScale = math.min(scalex, scaley)
end

-------------------------------------------------------------------------------
-- GAME CALLBACKS
-------------------------------------------------------------------------------
local testmap, testActor
function love.load()
	updateCanvasScale()
	testmap = Tilemap("maps/testmap.lua", Atlas("gfx/tiles.png", 16))
	testActor = Actor(16, 16, 16, 16, Atlas("gfx/anim.png", 16))
end

function love.update(dt)
	local x, y = 0, 0
	-- temp input
	if love.keyboard.isScancodeDown("a") then
		x = x - 2
	end
	if love.keyboard.isScancodeDown("d") then
		x = x + 2
	end
	if love.keyboard.isScancodeDown("w") then
		y = y - 2
	end
	if love.keyboard.isScancodeDown("s") then
		y = y + 2
	end

	testActor.vx = x
	testActor.vy = y

	testActor:phys(testmap)
	testActor:animate()
end

function love.draw()
	-- draw to the canvas
	love.graphics.setCanvas(nativeCanvas)
		love.graphics.clear()
		testmap:draw(0, 0)
		testActor:draw()
	love.graphics.setCanvas()

	-- scale the canvas to match the window scale
	love.graphics.push()
		love.graphics.scale(canvasScale)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(nativeCanvas, 0, 0)
	love.graphics.pop()

	-- debug stuff
	love.graphics.setColor(0, 0, 0, 0.8)
	love.graphics.print(love.timer.getFPS(), 11, 11)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print(love.timer.getFPS(), 10, 10)
end

function love.quit()

end

love.run = require "run"

-------------------------------------------------------------------------------
-- WINDOW CALLBACKS
-------------------------------------------------------------------------------

function love.focus(hasFocus)

end

function love.mousefocus(hasFocus)

end

function love.resize(w, h)
	updateCanvasScale()
end

-------------------------------------------------------------------------------
-- KEYBOARD CALLBACKS
-------------------------------------------------------------------------------

function love.keypressed(key, scan)
	--temporary quit
	if scan == "escape" then
		love.event.push "quit"
	end
end

function love.keyreleased(key, scan)

end

-------------------------------------------------------------------------------
-- MOUSE CALLBACKS
-------------------------------------------------------------------------------

function love.mousemoved(x, y, dx, dy)

end

function love.mousepressed(x, y, btn)

end

function love.mousereleased(x, y, btn)

end

-------------------------------------------------------------------------------
-- GAMEPAD CALLBACKS
-------------------------------------------------------------------------------

function love.joystickadded(joystick)

end

function love.gamepadaxis(joystick, axis, value)

end

function love.gamepadpressed(joystick, btn)

end

function love.gamepadreleased(joystick, btn)

end
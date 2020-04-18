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
local windowScale = 1
local canvasx = 0
local canvasy = 0

function updateCanvasScale()
	local w, h = love.graphics.getDimensions()
	local scalex = w / nativeWidth
	local scaley = h / nativeHeight

	canvasScale = math.min(scalex, scaley)

	canvasx = (w - nativeWidth * canvasScale) * 0.5
	print(w, nativeWidth * canvasScale, canvasx)
	canvasy = (h - nativeHeight * canvasScale) * 0.5
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

	local joystick = love.joystick.getJoysticks()[1]

	-- temp input
	local axisX, axisY = 0, 0
	local dpup, dpdown, dpleft, dpright
	local deadZone = 0.25

	if joystick then
		axisX = joystick:getGamepadAxis "leftx"
		axisY = joystick:getGamepadAxis "lefty"
		
		dpleft = joystick:isGamepadDown "dpleft"
		dpright = joystick:isGamepadDown "dpright"
		dpup = joystick:isGamepadDown "dpup"
		dpdown = joystick:isGamepadDown "dpdown"
	end

	if love.keyboard.isScancodeDown "a" or dpleft or axisX < -deadZone then
		x = x - 1
	end
	if love.keyboard.isScancodeDown "d" or dpright or axisX > deadZone then
		x = x + 1
	end
	if love.keyboard.isScancodeDown "w" or dpup or axisY < -deadZone then
		y = y - 1
	end
	if love.keyboard.isScancodeDown "s" or dpdown or axisY > deadZone then
		y = y + 1
	end

	local velocity = vector(x, y):normalizeInplace()
	velocity = velocity * 2
	testActor.vx = velocity.x
	testActor.vy = velocity.y

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
		love.graphics.translate(canvasx, canvasy)
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

function love.joystickremoved(joystick)

end

function love.gamepadaxis(joystick, axis, value)

end

function love.gamepadpressed(joystick, btn)

end

function love.gamepadreleased(joystick, btn)

end
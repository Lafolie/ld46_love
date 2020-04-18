--[[
	MAIN ENTRY
]]

class = require "lib.class"
vector = require "lib.vector"

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
function love.load()
	updateCanvasScale()
end

function love.update(dt)

end

function love.draw()
	love.graphics.push()
		love.graphics.scale(canvasScale)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(nativeCanvas, 0, 0)
	love.graphics.pop()

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
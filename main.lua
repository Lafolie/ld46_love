--[[
	MAIN ENTRY
]]

class = require "lib.class"
vector = require "lib.vector"

-------------------------------------------------------------------------------
-- GAME CALLBACKS
-------------------------------------------------------------------------------
function love.load()

end

function love.update(dt)

end

function love.draw()

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
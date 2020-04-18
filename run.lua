--[[
	love.run
	
	Standard run with fixed update step.
	Edited specifically for this project.
]]

return function()
	love.load(love.arg.parseGameArguments(arg), arg)

	-- We don't want the first frame's dt to include time taken by love.load.
	love.timer.step()

	local dt = 0
	local targetFrameLength = 1/60
	local frameTime =targetFrameLength --ensure that we always start with an update

	-- Main loop time.
	return function()
		-- Update frame timer
		frameTime = frameTime + love.timer.step()

		-- Call update if necessary
		if frameTime >= targetFrameLength then
			--process events
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end

			love.update()
			frameTime = 0 --frameTime - targetFrameLength
		end

		--Call draw
		if love.graphics.isActive() then
			love.graphics.origin()
			love.graphics.clear(love.graphics.getBackgroundColor())

			if love.draw then love.draw() end

			love.graphics.present()
		end

		if love.timer then love.timer.sleep(0.001) end
	end
end
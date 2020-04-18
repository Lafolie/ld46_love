--[[
	ACTOR

	Things that exist in the world
]]

require "class.atlas"

local floor = math.floor

Actor = class
{
	init = function(self, x, y, width, height, atlas)
		-- positional properties
		self.x = x
		self.y = y
		self.width = width
		self.height = height
		self.vx = 0
		self.vy = 0
		
		-- graphics
		self.color = {0.8, 0.1, 0.3, 1}
		self.atlas = atlas
		self.quad = 1
		self.animFrame = 0
		self.animFramesPerQuad = 4
		self.animIndex = 1

		-- temp
		self.anims =
		{
			idle = {1, 2, 3, 4}
		}

		self.currentAnim = self.anims.idle
	end,

	draw = function(self)
		-- love.graphics.setColor(1, 0.1, 0.5, 0.5)
		-- love.graphics.rectangle("fill", floor(self.x), floor(self.y), self.width, self.height)
		local atlas = self.atlas
		love.graphics.setColor(self.color)
		love.graphics.draw(atlas.img, atlas.quads[self.quad],  floor(self.x), floor(self.y))
	end,

	animate = function(self)
		self.animFrame = (self.animFrame + 1) % self.animFramesPerQuad
		if self.animFrame == 0 then
			self.animIndex = math.max(1, (self.animIndex + 1) % (#self.currentAnim + 1))
			self.quad = self.currentAnim[self.animIndex]	
		end
	end,

	setAnimation = function(self, animName)
		self.currentAnim = self.anims[animName]
		self.animFrame = 0
		self.animIndex = 1
	end,

	phys = function(self, map)
		local x, y = self.x, self.y
		local w, h = self.width, self.height
		local vx, vy = self.vx, self.vy
		local tileSize = map.tileSize
		local tiles = map.map

		local left, right, top, bottom, hit
		
		--move horizontally
		x = x + vx
		left = floor(x / tileSize)
		right = floor((x + w) / tileSize)
		top = floor(y / tileSize)
		bottom = floor((y + h - 1) / tileSize)

		for n = top, bottom do
			if tiles[n][left] < 8 then
				x = left * tileSize + tileSize
				vx = 0
			end

			if tiles[n][right] < 8 then
				x = right * tileSize - w
				vx = 0
			end
		end

		--move vertically
		y = y + vy
		left = floor(x / tileSize)
		right = floor((x + w - 1) / tileSize)
		top = floor(y / tileSize)
		bottom = floor((y + h) / tileSize)

		for n = left, right do
			if tiles[top][n] < 8 then
				y = top * tileSize + tileSize
				vy = 0
			end

			if tiles[bottom][n] < 8 then
				y = bottom * tileSize - h
				vy = 0
			end
		end

		-- finish!
		self.x = x
		self.y = y
		self.vx = vx
		self.vy = vy
	end,
}
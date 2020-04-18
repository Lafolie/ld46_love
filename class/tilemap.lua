--[[
	TILEMAP

]]

require "class.atlas"

Tilemap = class
{
	init = function(self, mapFilePath, atlas)
		self:loadMap(mapFilePath)
		self.atlas = atlas
		
		self.batch = love.graphics.newSpriteBatch(self.atlas.img, self.width * self.height)
		self:syncBatch()
	end,

	loadMap = function(self, filePath)
		local mapData = love.filesystem.load(filePath)()
		self.width = mapData.width
		self.height = mapData.height
		self.tileSize = mapData.tilewidth

		-- generate 2D map array
		self.map = {}
		for y = 0, self.height - 1 do
			local row = {}
			self.map[y] = row
			for x = 0, self.width - 1 do
				local n = y * self.width + x + 1
				row[x] = mapData.layers[1].data[n]
			end
		end
	end,

	syncBatch = function(self)
		local batch = self.batch
		local quads = self.atlas.quads
		local tsize = self.tileSize
		--clear the batch and repopulate
		batch:clear()

		for y = 0, self.height - 1 do
			local row = self.map[y]
			for x = 0, self.width - 1 do
				local n = row[x]
				if n > 0 then
					batch:add(quads[n], tsize * x, tsize * y)
				end
			end
		end

		batch:flush()
	end,

	draw = function(self, x, y)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(self.batch, x, y)
	end
}
--[[
	ATLAS

	Stores textures and quads
]]

Atlas = class
{
	init = function(self, imgPath, quadSize)
		self.img = love.graphics.newImage(imgPath)
		self.width, self.height = self.img:getDimensions()
		self.quadSize = quadSize

		self.quads = {}
		self:loadQuads()
	end,

	loadQuads = function(self)
		local nx = math.floor(self.width / self.quadSize) - 1
		local ny = math.floor(self.height / self.quadSize) - 1

		local w, h = self.width, self.height
		local size = self.quadSize
		local quads = self.quads

		for y= 0, ny do
			for x = 0, nx do
				local quad = love.graphics.newQuad(x * size, y * size, size, size, w, h)
				table.insert(quads, quad)
				print("Added quad", y*nx + x)
			end
		end
	end
}
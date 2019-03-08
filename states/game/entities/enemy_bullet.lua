local ent = ents.Derive("base")

function ent:load(x, y)
	self:setPos(x, y)
	self.direction = ""
	self.creator = ""
	sivir_bullet = love.graphics.newImage('Images/Textures/sivir_bullet.png')
	lucian_bullet = love.graphics.newImage('Images/Textures/lucian_bullet.png')
	kogmaw_bullet = love.graphics.newImage('Images/Textures/kogmaw_bullet.png')
	ranged_minion_bullet = love.graphics.newImage("Images/Textures/ranged_minion_bullet.png")
	self.w = 0
	self.h = 0
	self.velocity = 0
	self.dx = 0
	self.dy = 0
	self.damage = 0
end

function ent:setPos(x, y)
	self.x = x
	self.y = y
end

function ent:draw()
	if self.creator == "sivir" then
		self.image = sivir_bullet
		self.w = 32
		self.h = 32
	end
	if self.creator == "lucian" then
		self.image = lucian_bullet
		self.w = 20
		self.h = 9
	end
	if self.creator == "kogmaw" then
		self.image = kogmaw_bullet
		self.w = 12
		self.h = 12
	end
	if self.creator == "ranged_minion" then
		self.image = ranged_minion_bullet
		self.w = 11
		self.h = 11
	end

	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.image, self.x, self.y, 0, 0.5, 0.5)
end

function ent:update(dt)
	self.x = self.x + (self.dx*dt)
	self.y = self.y + (self.dy*dt)

	for i,ent in pairs(ents.objects) do
		if ent.type == "player" then
			local hit = self.checkCollision(self.x, self.y, 16, 16, playerX, playerY, 30, 30)
			if hit then
				ent.health = ent.health-self.damage
				ents:Destroy(self.id)
			end
		end
		if ent.type == "object" then
			local x, y = ent:returnPos()
			local hit = self.checkCollision(self.x, self.y, 16, 16, x, y, 32, 32)
			if hit then
				ents:Destroy(self.id)
			end
		end
	end
end

function ent:setDestiny()
	for i,ent in pairs(ents.objects) do
		if ent.type == self.creator then
			self.velocity = ent:returnBulletspd()
		end
	end

	local angle = math.atan2((playerY-self.y), (playerX-self.x))
	self.dx = self.velocity*math.cos(angle)
	self.dy = self.velocity*math.sin(angle)
end

function ent:setDirection(direction)
	self.direction = direction
end

function ent.checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1<x2+w2 and
	x2<x1+w1 and
	y1<y2+h2 and
	y2<y1+h1
end

function ent.insideBox(px, py, x, y, wx, wy)
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end

function ent:setCreator(creator)
	self.creator = creator
	if self.creator == "kogmaw" then
		self.damage = 5
	end
	if self.creator == "sivir" then
		self.damage = 10
	end
	if self.creator == "lucian" then
		self.damage = 15
	end
	if self.creator == "ranged_minion" then
		self.damage = 2
	end
end

function ent:checkBoundary()
	if self.x <= 0 then
		ents:Destroy(self.id)
	end

	if self.y <= 0 then
		ents:Destroy(self.id)
	end

	if self.x >= 710 then
		ents:Destroy(self.id)
	end

	if self.y >= 490 then
		ents:Destroy(self.id)	
	end
end

return ent

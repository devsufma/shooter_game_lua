local ent = ents.Derive("base")

function ent:load(x, y)
	self:setPos(x, y)
	arrow_right = love.graphics.newImage("Images/Textures/player_arrow_right.png")
	arrow_left = love.graphics.newImage("Images/Textures/player_arrow_left.png")
	self.w = 13
	self.h = 10
	self.direction = ""
	self.velocity = 250
	self.dx = 0
	self.dy = 0
	self.damage = 5
end

function ent:setPos(x, y)
	self.x = x
	self.y = y
end

function ent:update(dt)
	self:checkBoundary()
	for i,ent in pairs(ents.objects) do
		if ent.type == "player" then
			self.damage = ent:getStats()
		end
	end
			
	self.x = self.x + (self.dx*dt)
	self.y = self.y + (self.dy*dt)

	for i,ent in pairs(ents.objects) do
		if ent.type == "sivir" or ent.type == "lucian" or ent.type == "kogmaw" or ent.type == "udyr" or ent.type == "ranged_minion" or ent.type == "melee_minion" then
			local x,y = ent:returnPos()
			local hit =  self:checkCollision(self.x, self.y,self.w, self.h, ent.x, ent.y, ent.w, ent.h) 
			if hit then
				ent.health = ent.health-self.damage
				ents:Destroy(self.id)	
			end
		end
		if ent.type == "object" then
			local x,y = ent:returnPos()
			local hit =  self:checkCollision(self.x, self.y,self.w, self.h, ent.x, ent.y, ent.w, ent.h) 
			if hit then
				ents:Destroy(self.id)
			end
		end
	end
end

function ent:draw()
	love.graphics.setColor(152,143,143,255)
	if self.direction == "right" then
		love.graphics.draw(arrow_right, self.x, self.y, 0, 1, 1)
	elseif self.direction == "left" then
		love.graphics.draw(arrow_left, self.x, self.y, 0, 1, 1)
	end
end

function ent:setDestiny()
	local angle = math.atan2((mouseY-self.y), (mouseX-self.x))

	self.dx = self.velocity*math.cos(angle)
	self.dy = self.velocity*math.sin(angle)
end

function ent:setDirection(direction)
	self.direction = direction
end

function ent:insideBox(px, py, x, y, wx, wy)
	if px > x and px < x+wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end

function ent:checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1<x2+w2 and
	x2<x1+w1 and
	y1<y2+h2 and
	y2<y1+h1
end


function ent:checkBoundary()
	if self.x <= 29 then
		ents:Destroy(self.id)
	end

	if self.y <= 29 then
		ents:Destroy(self.id)
	end

	if self.x >= 750 then
		ents:Destroy(self.id)
	end

	if self.y >= 600 then
		ents:Destroy(self.id)	
	end
end


return ent

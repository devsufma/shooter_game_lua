local ent = ents.Derive("base")
local deltaTime = 0

function ent:load(x,y)
	self:setPos(x, y)
	self.imageRight = love.graphics.newImage("Images/Sprites/melee_minion_right.png")
	self.imageLeft = love.graphics.newImage("Images/Sprites/melee_minion_left.png")
	self.w = 21.57
	self.h = 32.25
	self.image = self.imageRight
	self.health = 10
	self.mvspeed = 45
	self.collision = false
end

function ent:setPos(x, y)
	self.x = x
	self.y = y
end

function ent:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.image, self.x, self.y, 0, 0.75, 0.75, 0)
	love.graphics.setColor(255,0,0,255)
	love.graphics.rectangle("fill", self.x, self.y-4, self.health/10*30, 4)
end

function ent:update(dt)
	self:checkBoundary()

	--andando pra cima
	if self.y > playerY and (self.x >=playerX or self.x <= playerX) then
		for i,ent in pairs(ents.objects) do
			if ent.type ~= "player_bullet" and ent.type ~= "enemy_bullet" and ent.id ~= self.id then
				x,y = ent:returnPos() 
				if self:checkCollision(self.x, self.y-2, 30, 2, x, y+30, 30, 2 ) then
					self.collision = true
					if ent.type == "player" then
						ent.health = ent.health - 2
					end
					break
				end
			end
		end
		if not self.collision then
			self.y = self.y - self.mvspeed*dt
		end
		self.collision = false
	end

	--andando pra baixo
	if self.y < playerY and (self.x >=playerX or self.x <= playerX) then
		for i,ent in pairs(ents.objects) do
			if ent.type ~= "player_bullet" and ent.type ~= "enemy_bullet" and ent.id ~= self.id then
				x,y = ent:returnPos() 
				if self:checkCollision(self.x, self.y+30, 30, 2, x, y-2, 30, 2 ) then
					self.collision = true
					if ent.type == "player" then
						ent.health = ent.health - 2
					end
					break
				end
			end
		end
		if not self.collision then
			self.y = self.y + self.mvspeed*dt
		end
		self.collision = false
	end

	--andando pra esquerda
	if self.x > playerX and (self.y >= playerY or self.y <= playerY) then
		for i,ent in pairs(ents.objects) do
			if ent.type ~= "player_bullet" and ent.type ~= "enemy_bullet" and ent.id ~= self.id then
				x,y = ent:returnPos() 
				if self:checkCollision(self.x-2, self.y, 2, 30, x+30, y, 2, 30) then
					self.collision = true
					if ent.type == "player" then
						ent.health = ent.health - 2
					end
					break
				end
			end
		end
		if not self.collision then
			self.x = self.x - self.mvspeed*dt
		end
		self.collision = false
	end

	--andando pra direita
	if self.x < playerX and (self.y >= playerY or self.y <= playerY) then
		for i,ent in pairs(ents.objects) do
			if ent.type ~= "player_bullet" and ent.type ~= "enemy_bullet" and ent.id ~= self.id then
				x,y = ent:returnPos() 
				if self:checkCollision(self.x+30, self.y, 2, 30, x-2, y, 2, 30) then
					self.collision = true
					if ent.type == "player" then
						ent.health = ent.health - 2
					end
					break
				end
			end
		end
		if not self.collision then
			self.x = self.x + self.mvspeed*dt
		end
		self.collision = false
	end

	if self.health<=0 then
		self.health = 0
		ents:Destroy(self.id)
		gold = gold + 150
		enemies_remaining = enemies_remaining - 1
	end

	if self.x < playerX then
		self.image = self.imageRight
		self:draw()
	else
		self.image = self.imageLeft
		self:draw()
	end

end


function ent:returnPos()
	return self.getPos()
end

function ent:checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1<x2+w2 and
	x2<x1+w1 and
	y1<y2+h2 and
	y2<y1+h1
end

function ent:checkBoundary()
	if self.x <= 0 then
		self.x = 0
	end

	if self.y <= 0 then
		self.y = 0
	end

	if self.x >= 710 then
		self.x = 710
	end

	if self.y >= 490 then
		self.y = 490
	end
end

return ent

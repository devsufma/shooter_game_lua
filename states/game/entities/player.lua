local ent = ents.Derive("base")
local deltaTime = 0

function ent:load(x,y)
	self:setPos(x, y)
	self.imageLeft = love.graphics.newImage("Images/Sprites/vayne-left.png")
	self.imageRight =  love.graphics.newImage("Images/Sprites/vayne-right.png")
	self.w = 42
	self.h = 33.75
	self.image = self.imageRight 
	self.collision = false
	self.speed = 64
	self.health = 150
	self.damage = 2
	self.atkspeed = 0.60
	atkSound = love.audio.newSource("Audios/vayne_basic_attack.wav", "static")
end

function ent:setPos(x, y)
	self.x = x
	self.y = y
end

function ent:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.image, self.x, self.y, 0, 0.75, 0.75, 0)

	love.graphics.setColor(255,0,0,255)
	love.graphics.rectangle("fill", self.x, self.y-2, self.health/150*30, 4)
end

function ent:update(dt)
	mouseX, mouseY = love.mouse.getPosition()
	playerX, playerY = self.x, self.y

	self:checkBoundary()

	--ANDANDO PRA CIMA 
	if love.keyboard.isDown('w')then
		for i,ent in pairs(ents.objects) do
			if ent.type ~= "player_bullet" and ent.type ~= "enemy_bullet" and ent.id ~= self.id then
				x,y = ent:returnPos() 
				if self:checkCollision(self.x, self.y-2, 30, 2, x, y+30, 30, 2 ) then
					self.collision = true
					break
				end
			end
		end
		if not self.collision then
			self.y = self.y - self.speed*dt
		end
		self.collision = false
	end

	--ANDANDO PRA ESQUERDA
	if love.keyboard.isDown('a')then
		for i,ent in pairs(ents.objects) do
			if ent.type ~= "player_bullet" and ent.type ~= "enemy_bullet" and ent.id ~= self.id then
				x,y = ent:returnPos() 
				if self:checkCollision(self.x-2, self.y, 2,30, x+30, y, 2, 30 ) then
					self.collision = true
					break
				end
			end
		end
		if not self.collision then
			self.x = self.x - self.speed*dt
		end
		self.collision = false
	end

	--ANDANDO PRA BAIXO
	if love.keyboard.isDown('s')then
		for i,ent in pairs(ents.objects) do
			if ent.type ~= "player_bullet" and ent.type ~= "enemy_bullet" and ent.id ~= self.id then
				x,y = ent:returnPos() 
				if self:checkCollision(self.x, self.y+30, 30,2, x, y-2, 30, 2 ) then
					self.collision = true
					break
				end
			end
		end
		if not self.collision then
			self.y = self.y + self.speed*dt
		end
		self.collision = false
	end

	--ANDANDO PRA DIREITA
	if love.keyboard.isDown('d')then
		for i,ent in pairs(ents.objects) do
			if ent.type ~= "player_bullet" and ent.type ~= "enemy_bullet" and ent.id ~= self.id then
				x,y = ent:returnPos() 
				if self:checkCollision(self.x+30, self.y, 2,30, x-2, y, 2, 30 ) then
					self.collision = true
					break
				end
			end
		end
		if not self.collision then
			self.x = self.x + self.speed*dt
		end
		self.collision = false
	end

	deltaTime = deltaTime + dt 
	
	if love.mouse.isDown(1) and deltaTime > self.atkspeed then
		if mouseX > self.x then
			local bullet = ents.Create("player_bullet", self.x, self.y, "right")
			atkSound:play()
			bullet:setDestiny()
		elseif mouseX < self.x then
			local bullet = ents.Create("player_bullet", self.x, self.y, "left")
			bullet:setDestiny()
			atkSound:play()
		end
		deltaTime = 0
	end

	if self.x < mouseX then
		self.image = self.imageRight
		self:draw()
	else
		self.image = self.imageLeft
		self:draw()
	end

end


function ent:getStats()
	return self.damage, self.speed, self.atkspeed
end

function ent:returnHealth()
	return self.health
end

function ent:increaseDmg(n)
	self.damage = self.damage + n
end

function ent:increaseMvspeed(n)
	self.speed = self.speed + n
end

function ent:increaseAtkspeed(n)
	self.atkspeed = self.atkspeed - n
end

function ent:checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	return x1<x2+w2 and
	x2<x1+w1 and
	y1<y2+h2 and
	y2<y1+h1
end

function ent:returnPos()
	return self.getPos()
end

function ent:checkBoundary()
	if self.x <= 29 then
		self.x = 29
	end

	if self.y <= 29 then
		self.y = 29
	end

	if self.x >= 730 then
		self.x = 730
	end

	if self.y >= 540 then
		self.y = 540
	end
end

return ent

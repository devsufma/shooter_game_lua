local ent = ents.Derive("base")

function ent:load(x, y)
	self:setPos(x, y)
	self.w = 32
	self.h = 32
end

function ent:setPos(x, y)
	self.x = x
	self.y = y
end

function ent:update(dt)
end

function ent:returnPos()
	return self.x, self.y
end

return ent

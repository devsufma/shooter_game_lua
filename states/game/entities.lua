ents = {}
ents.objects = {}
ents.objpath = "states/game/entities/"
local register = {}
local id = 0

function ents.Startup()
	register["player"] = love.filesystem.load(ents.objpath.."player.lua")
	register["sivir"] = love.filesystem.load(ents.objpath.."sivir.lua")
	register["kogmaw"] = love.filesystem.load(ents.objpath.."kogmaw.lua")
	register["udyr"] = love.filesystem.load(ents.objpath.."udyr.lua")
	register["lucian"] = love.filesystem.load(ents.objpath.."lucian.lua")
	register["player_bullet"] = love.filesystem.load(ents.objpath.."player_bullet.lua")
	register["enemy_bullet"] = love.filesystem.load(ents.objpath.."enemy_bullet.lua")
	register["ranged_minion"] = love.filesystem.load(ents.objpath.."ranged_minion.lua")

	register["melee_minion"] = love.filesystem.load(ents.objpath.."melee_minion.lua")
	register["object"] = love.filesystem.load(ents.objpath.."object.lua")
end

function ents.Derive(name)
	return love.filesystem.load(ents.objpath..name..".lua")()
end

function ents.Create(name, x, y, direction, creator)
	if not x then
		x = 0
	end
	if not y then
		y = 0 
	end

	if register[name] then
		id = id+1
		local ent = register[name]()
		ent:load()
		ent.type = name
		if direction then
			ent:setDirection(direction)
		end
		if creator then
			ent:setCreator(creator)
		end
		ent:setPos(x, y)
		ent.id = id
		ents.objects[id] = ent
		return ents.objects[id]
	else
		return false
	end
end

function ents:Destroy(id)
	if ents.objects[id] then
		ents.objects[id] = nil
	end
end

function ents:update(dt)
	for i, ent in pairs(ents.objects) do
		if ent.update then
			ent:update(dt)
		end
	end
end

function ents:draw()
	for i,ent in pairs(ents.objects) do
		if ent.draw then
			ent:draw()
		end
	end
end


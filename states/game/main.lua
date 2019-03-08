function load()
	require("states/game/entities")
	require("states/game/map-functions")

	enemies_remaining = 0
	enemies_total = 5
	level = 1
	draw_lvl1 = true
	draw_lvl2 = true
	draw_lvl3 = true
	draw_lvl4 = true
	draw_lvl5 = true
	ents.Startup()
	
	--loadMap("states/game/maps/garden.lua")
	loadMap("states/game/maps/kitchen.lua")

	gold = 0
	is_paused = false
	
	ents.Create("player", 90, 120)

	--Fonte
	font = love.graphics.newFont("fonts/manaspc.ttf", 20)
	love.graphics.setFont(font)

	--Itens
	dmg1 = love.graphics.newImage("Images/Itens/pickaxe.png")
	dmg2 = love.graphics.newImage("Images/Itens/bfsword.png")
	dmg3 = love.graphics.newImage("Images/Itens/bloodthirster.png")
	dmg4 = love.graphics.newImage("Images/Itens/bloodthirster_locked.png")
	mvspeed1 = love.graphics.newImage("Images/Itens/boots.png")
	mvspeed2 = love.graphics.newImage("Images/Itens/swift.png")
	mvspeed3 = love.graphics.newImage("Images/Itens/swift_locked.png")
	atkspeed1 = love.graphics.newImage("Images/Itens/dagger.png")
	atkspeed2 = love.graphics.newImage("Images/Itens/zeal.png")
	atkspeed3 = love.graphics.newImage("Images/Itens/phantom-dancer.png")
	atkspeed4 = love.graphics.newImage("Images/Itens/phantom-dancer_locked.png")

	can_upg_dmg = true
	can_upg_atkspd = true
	can_upg_mvspd = true

	playerHealth = 50

	bu = {}
	bu.dmg = {image = dmg1, x = 110, y = 150, price = 850, lvl = 1, type = "dmg"}
	bu.atkspeed = {image = atkspeed1, x = 110, y = 300, price = 450, lvl = 1, type = "atkspd"}
	bu.mvspeed = {image = mvspeed1, x = 110, y = 450, price = 350, lvl = 1, type = "mvspd"}
end

function love.draw()
	love.graphics.setColor(255,255,255,255)

	drawMap()
	ents:draw()
	
	love.graphics.setColor(25,25,25,255)
	love.graphics.print("Enemies Remaining: "..enemies_remaining.."/"..enemies_total, 16, 16, 0, 1, 1)
	love.graphics.print("Gold: "..gold, 350, 16, 0, 1, 1)

	if is_paused then
		love.graphics.setColor(100,100,100,100)
		love.graphics.rectangle("fill", 100, love.graphics.getHeight()/8, love.graphics.getWidth()-200, 6*love.graphics.getHeight()/8)

		love.graphics.setColor(255,0,0,255)
		love.graphics.print("Paused", 350, 100, 0, 1, 1)

		love.graphics.setColor(255,255,255,255)
		buttonsDraw()
	end
	
	if playerHealth <= 0 then
		drawDeathScreen()
	end

end

function buttonsDraw()
	local damage, mvspeed, atkspeed = 0, 0, 0
	local prcDmg, prcSpd, prcAtkspd = bu.dmg.price, bu.mvspeed.price, bu.atkspeed.price
	for i, button in pairs(bu) do
		love.graphics.draw(button.image, button.x, button.y)
	end

	for i, ent in pairs (ents.objects) do
		if ent.type == "player" then
			damage, mvspeed, atkspeed = ent:getStats()
			playerHealth  = ent:returnHealth() 
		end
	end
	love.graphics.print("Damage: "..damage, 190, 150, 0, 1, 1)
	love.graphics.print("Price: "..prcDmg, 190, 180, 0, 1, 1)

	love.graphics.print("Atk Speed: "..atkspeed, 190, 300, 0, 1, 1)
	love.graphics.print("Price: "..prcAtkspd, 190, 330, 0, 1, 1)

	love.graphics.print("Mv Speed: "..mvspeed, 190, 450, 0, 1,1)
	love.graphics.print("Price: "..prcSpd, 190, 480, 0, 1, 1)
end

function love.update(dt)
	if level == 1 and draw_lvl1 == true then
		for i=1,3 do
			ents.Create("ranged_minion", 294+i*20, 279)
			ents.Create("melee_minion", 335+i*20 ,279+i*20 )
		end
		ents.Create("kogmaw", 180, 180)
		enemies_remaining = 7
		enemies_total = 7
		draw_lvl1 = false
	end

	if level == 2 and draw_lvl2 == true then
		for i=1,4 do
			ents.Create("melee_minion", i*20, i*20)
			ents.Create("ranged_minion", i*20, i*20)
		end
		ents.Create("sivir", 180, 180)
		enemies_remaining = 9
		enemies_total = 9
		draw_lvl2 = false
	end

	if level == 3 and draw_lvl3 == true then
		for i = 1, 5 do
			ents.Create("melee_minion", i*20, i*20)
			ents.Create("ranged_minion", i*20, i*20)
		end
		ents.Create("lucian", 180, 180)
		enemies_remaining = 11
		enemies_total = 11
		draw_lvl3 = false
	end

	if level == 4 and draw_lvl4 == true then
		for i = 1, 6 do 
			ents.Create("melee_minion", i*20, i*20)
			ents.Create("ranged_minion", i*20, i*20)
		end
		ents.Create("udyr", 180, 180)
		enemies_remaining = 13
		enemies_total = 13
		draw_lvl4 = false
	end

	if enemies_remaining <=0 then
		if level == 4 then
			level = 5
		end
		if level == 3 then
			level = 4
		end
		if level == 2 then
			level = 3
		end
		if level == 1 then
			level = 2 
		end 
	end

	if enemies_remaining <= 0 and level == 5 then
		loadState("victory")
	end

	if is_paused then
		return
	end
	for i, ent in pairs (ents.objects) do
		if ent.type == "player" then
			playerHealth  = ent:returnHealth() 
		end
	end
	if playerHealth <= 0 then
		loadState("defeat")
		return
	end

	ents:update(dt)

end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
		is_paused = not is_paused
	end
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		if is_paused == true then
			for i, button in pairs(bu) do
				if insideBox(x, y, button.x, button.y, 64, 64) then
					if button.type == "dmg" and gold >= button.price then
						gold = gold - button.price
						for i, ent in pairs (ents.objects) do
							if ent.type == "player" and can_upg_dmg == true then
								ent:increaseDmg(2)
							end
						end
						if button.lvl == 1 then
							button.lvl = 2
							button.image = dmg2
							button.price = 1550
						elseif button.lvl == 2 then
							button.lvl = 3
							button.image = dmg3
							button.price = 1450
						elseif button.lvl == 3 then
							button.lvl = 4
							button.image = dmg4
							button.price = 0
							can_upg_dmg = false
						end

					elseif button.type == "atkspd" and gold >= button.price then
						gold = gold - button.price
						for i, ent in pairs (ents.objects) do
							if ent.type == "player" and can_upg_atkspd == true then
								ent:increaseAtkspeed(0.15)
							end
						end
						if button.lvl == 1 then
							button.lvl = 2
							button.image = atkspeed2
							button.price = 1100
						elseif button.lvl == 2 then
							button.lvl = 3
							button.image = atkspeed3
							button.price = 1050
						elseif button.lvl == 3 then
							button.lvl = 4
							button.image = atkspeed4
							button.price = 0
							can_upg_atkspd = false
						end

					elseif button.type == "mvspd" and gold >= button.price then
						gold = gold - button.price
						for i, ent in pairs (ents.objects) do
							if ent.type == "player" and can_upg_mvspd == true then
								ent:increaseMvspeed(20)
							end
						end

						if button.lvl == 1 then
							button.lvl = 2
							button.image = mvspeed2
							button.price = 650
						elseif button.lvl == 2 then
							button.lvl = 3
							button.image = mvspeed3
							button.price = 0
							can_upg_mvspd = false
						end
					end
				end
			end
		end
	end
end

function addGold(n)
	gold = gold + tonumber(n)
end


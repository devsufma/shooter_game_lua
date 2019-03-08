function load()
	victory = love.graphics.newImage("Images/Textures/victory.png")
	continueOff = love.graphics.newImage("Images/Textures/continue.png")
	 continueOn = love.graphics.newImage("Images/Textures/continueClicked.png")
	buttons = {
		{buttonOff = continueOff, buttonOn = continueOn, x = 450, y = 400, w=256 ,h=50, action = 'continue'}
	}
end

function drawButton(off, on, x, y, w, h, mx, my)
	local ins = insideBox(mx, my, x-(w/2), y-(h/2), w-100, h)
	love.graphics.setColor(255,255,255,255)

	if ins then
		love.graphics.draw(on, x, y, 0, 1, 1, (w/2), (h/2))
	else
		love.graphics.draw(off, x, y, 0, 1, 1, (w/2), (h/2))
	end
end

function love.draw()
	local x,y = love.mouse.getPosition()

	for k,v in pairs(buttons) do
		drawButton(v.buttonOff, v.buttonOn, v.x, v.y, v.w, v.h, x, y)
	end
	love.graphics.draw(victory, 250, 50, 0, 0.30, 0.30)
end

function love.update(dt)
end

function love.mousepressed(x, y, button)
	if button == 1 then
		for k,v in pairs(buttons) do
			local ins = insideBox(x, y, v.x-(v.w/2), v.y-(v.h/2), v.w-100, v.h)
			if ins and v.action == "continue" then
				love.event.quit()
			end
		end
	end
end

function insideBox(px, py, x, y, wx, wy)
	if px > x and px < x+wx then
		if py > y and py < y+wy then
			return true
		end
	end
	return false
end

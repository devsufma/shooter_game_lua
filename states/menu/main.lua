function load()

	background = love.graphics.newImage("Images/Textures/background.jpg")

	imgPlay = love.graphics.newImage("Images/Textures/playoff.png")
	imgPlayOn = love.graphics.newImage("Images/Textures/playon.png")
	button = imgPlay
	buttonW = 139
	buttonH = 48

	
end

function love.draw()
	love.graphics.draw(button, 325, 400)
end

function love.update(dt)
	mouseX, mouseY = love.mouse.getPosition()
	if insideBox(mouseX, mouseY, 325, 400, buttonW, buttonH) then
		button = imgPlayOn
	else
		button = imgPlay
	end
end

function insideBox(px, py, x, y, w, h)
	if px > x and px < x+w then
		if py > y and py < y+h then
			return true
		end
	end
	return false
end

function love.focus(bool)
end

function love.mousepressed(x, y, button)
	if button == 1 and insideBox(x, y, 325, 400, buttonW, buttonH) then
		loadState('game')
	end
end


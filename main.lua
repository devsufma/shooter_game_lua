function clearLoveCallbacks()
	love.draw = nil
	love.joystickpressed = nil
	love.joystickreleased = nil
	love.keypressed = nil
	love.keyreleased = nil
	love.mousepressed = nil
	love.mousereleased = nil
	love.update = nil
end

function loadState(name)
	clearLoveCallbacks()
	local path = "states/"..name
	require(path.."/main")
	load()
end

function love.load()
	--cursor = love.mouse.newCursor("Images/Textures/cursor.png")
	--love.mouse.setCursor(cursor)
	loadState("menu")
end

function love.draw()
end

function love.update(dt)
end

function love.focus(bool)
end

function love.keypressed(key, unicode)
end

function love.keyreleased(key)
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end

function love.quit()
end

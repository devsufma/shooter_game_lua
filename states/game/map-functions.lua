function loadMap(path)
	love.filesystem.load(path)()
end

function newMap(tileW, tileH, tilesetPath, tileString, quadInfo)
	TileW = tileW
	TileH = tileH
	Tileset = love.graphics.newImage(tilesetPath)
  
	--tilesetW = 128, tilesetH = 96, por que a imagem toda é 128x96
	local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
  
	Quads = {}
  
	for _,info in ipairs(quadInfo) do
	-- info[1] = o caractere, info[2] = x, info[3] = y
		Quads[info[1]] = love.graphics.newQuad(info[2], info[3], TileW,  TileH, tilesetW, tilesetH)
	end
  
	TileTable = {}
  
	--vê a largura da primeira linha(que no caso é 25)
	local width = #(tileString:match("[^\n]+"))

	--cria uma matriz
	for x = 1,width,1 do TileTable[x] = {} end

	local rowIndex,columnIndex = 1,1
	for row in tileString:gmatch("[^\n]+") do
		--checa se essa linha tem a mesma largura da primeira(25)
		assert(#row == width, 'mapa não ta alinhado, largura da linha: ' .. tostring(rowIndex) .. ' deve ser ' .. tostring(width) .. 'mas é: ' .. tostring(#row))
		columnIndex = 1
		for character in row:gmatch(".") do
			--criando a matriz
			TileTable[columnIndex][rowIndex] = character
			--vai pra proxima coluna
			columnIndex = columnIndex + 1
		end
		--vai pra proxima linha
		rowIndex=rowIndex+1
	end

	for x, column in ipairs(TileTable) do
		for y,char in ipairs(column) do
			if char ~= " " then
				--para todos os caracteres que não forem espaços, criar um objeto (espaço é chão), criar um objeto em todos os espaços que não são chão
				ents.Create("object", (x-1)*TileW, (y-1)*TileH)
			end
		end
	end
end

function drawMap()
	for x,column in ipairs(TileTable) do
		for y,char in ipairs(column) do
			love.graphics.draw(Tileset, Quads[char] , (x-1)*TileW, (y-1)*TileH)
		end
	end
end

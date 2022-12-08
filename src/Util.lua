function GenerateQuads(atlas, tilewidth, tileheight)
    --medidas para devidir o meu ficheiro em varias colunas e linhas
    local sheetwidth = atlas:getWidth() / tilewidth
    local sheetheight = atlas:getHeight() / tileheight

    local sheetcounter = 1
    local spritesheet = {}

    --Matriz de sprites
    --Por cada coluna
    --iterar o tamaho do meu spritesheet (-1 porque começa no elemento [0], tamanho do meu array - 1)
    for y = 0, sheetheight - 1 do
        --Por cada linha
        for x = 0, sheetwidth - 1 do
            --index do meu array/tabela naquela posiçao vai guardar uma imagem
            spritesheet[sheetcounter] = 
                love.graphics.newQuad(x * tilewidth, y * tileheight, 
                tilewidth, tileheight, atlas:getDimensions())
            sheetcounter = sheetcounter + 1
        end
    end

    --retorna o meu ficheiro dividido e agrupado numa tabela
    return spritesheet
end

--Cortar a tabela
function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced+1] = tbl[i]
    end
    return sliced
end

--Como os paddles sao de tamanhos diferentes, é necessario defenir as sua dimenssoes manualmente
function GenerateQuadsPaddles(atlas)
    local x = 0
    local y = 64

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        --pequeno
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        counter = counter + 1
        --medio
        quads[counter] = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions())
        counter = counter + 1
        --grande
        quads[counter] = love.graphics.newQuad(x + 96, y, 96, 16, atlas:getDimensions())
        counter = counter + 1
        --gigante
        quads[counter] = love.graphics.newQuad(x, y + 16, 128, 16, atlas:getDimensions())
        counter = counter + 1

        --Passar para a proxima skin de paddles
        x = 0
        y = y + 32
    end
    return quads
end

function GenerateQuadsBalls(atlas)
    local x = 96
    local y = 48

    local counter = 1
    local quads = {}

    --primeira linha de skins da bola(4 elementos)
    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        x = x + 8
        counter = counter + 1
    end

    --segunda linha de skins da bola (3 elementos)
    x = 96
    y = 56

    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        x = x + 8
        counter = counter + 1
    end

    return quads
end

function GenerateQuadsBricks(atlas)
    return table.slice(GenerateQuads(atlas, 32, 16), 1, 21)
end
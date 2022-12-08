LevelMaker = Class{}

NONE = 1
SINGLE_PYRAMID = 2
MULTI_PYRAMID = 3

SOLID = 1
ALTERNATE = 2
SKIP = 3
NONE = 4

function LevelMaker.createMap(level)
    local bricks = {}

    local numRows = math.random(1, 5)
    local numCols = math.random(7, 13)

    numCols = numCols % 2 == 0 and (numCols + 1) or numCols

    local highestTier = math.min(3, math.floor(level / 5))
    local highestColor = math.min(5, level % 5 + 3)

    for y = 1, numRows do

        --alternar se salta uma linha, sem renderizar nenhum bloco
        local skipPattern = math.random(1, 2) == 1 and true or false

        --Se o padrao de cores da linha vais ser ou nao alternado
        local alternatePattern = math.random(1, 2) == 1 and true or false

        --Escolher 2 cores para alternar
        local alternateColor1 = math.random(1, highestColor)
        local alternateColor2 = math.random(1, highestColor)

        local alternateTier1 = math.random(0, highestTier)
        local alternateTier2 = math.random(0, highestTier)

        --saltar um bloco
        local skipFlag = math.random(2) == 1 and true or false
        --alternar um bloco
        local alternateFlag = math.random(2) == 1 and true or false

        --cor a usar caso nao vai ser alternada a cor da linha(Cor padrao)
        local solidColor = math.random(0, highestColor)
        local solidTier = math.random(1, highestTier)

        for x = 1, numCols do

            --Inverter entre alternado ou nao na proxima iteraçao
            if skipPattern and skipFlag then
                skipFlag = not skipFlag

                --bloco continue em lua
                goto continue
            else
                skipFlag = not skipFlag
            end

            b = Brick(
                --Cordenadas de x
                (x - 1) * 32 + 8 + (13 - numCols) * 16,
                --coordenadas de y 
                y * 16 
            )

            --Se estiver-mos a alternar , decidir qual as 2 cores a alternar
            if alternateFlag and alternatePattern then
                b.color = alternateColor1
                b.tier = alternateTier1
                alternateFlag = not alternateFlag
            else
                b.color = alternateColor2
                b.tier = alternateTier2
                alternateFlag = not alternateFlag
            end

            --Caso nao seja para alternar usar a cor padrao
            if not alternatePattern then
                b.color = solidColor
                b.tier = solidTier
            end
        
            table.insert(bricks, b)

            --Continue 
            ::continue::
        end
    end

    --Caso seja gerado um mapa com todas as linhas vazias(probalidade pequena), voltar a gerar um mapa ate 
    --que seja gerado um com pelo menos uma linha
    if #bricks == 0 then
        return self.createMap(level)
    else
         return bricks
    end
end

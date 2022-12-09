EnterHighScoreState = Class{__includes = BaseState}

--ASCII 'A' = 65
local chars = {
    [1] = 65, 
    [2] = 65, 
    [3] = 65
}
local highlitedChar = 1

function EnterHighScoreState:enter(params)
    self.highscores = params.highscores
    self.score = params.score
    self.scoreIndex = params.scoreIndex
end

function EnterHighScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local name = string.char(chars[1]) .. string.char(chars[2]) .. string.char(chars[3])

        for i = 10, self.scoreIndex, -1 do
            self.highscores[i + 1] = {
                name = self.highscores[i].name,
                score = self.highscores[i].score
            }
        end

        self.highscores[self.scoreIndex].name = name
        self.highscores[self.scoreIndex].score = self.score

        local scoresStr = ''

        for i = 1, 10 do
            scoresStr = scoresStr .. self.highscores[i].name .. '\n'
            scoresStr = scoresStr .. tostring(self.highscores[i].score) .. '\n'
        end

        love.filesystem.write('breakout.lst', scoresStr)
        gStateMachine:change('highscores', {
            highscores = self.highscores
        })
    end

    --Navegar pelos tres caracteres
    if love.keyboard.wasPressed('left') and highlitedChar > 1 then
        highlitedChar = highlitedChar - 1
        gSounds['select']:play()
    elseif love.keyboard.wasPressed('right') and highlitedChar < 3 then
        highlitedChar = highlitedChar + 1
        gSounds['select']:play()
    end

    --Escolher o valor de cada caracter
    if love.keyboard.wasPressed('up') then
        chars[highlitedChar] = chars[highlitedChar] + 1
        --Se chegar ao caracter 'Z' volta para o 'A'
        if chars[highlitedChar] > 90 then
            chars[highlitedChar] = 65
        end
    elseif love.keyboard.wasPressed('down') then
        chars[highlitedChar] = chars[highlitedChar] - 1
        if chars[highlitedChar] < 65 then
            chars[highlitedChar] = 90
        end
    end
end

function EnterHighScoreState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Your Score: ' .. tostring(self.score), 0, 30, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['large'])

    if highlitedChar == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[1]), VIRTUAL_WIDTH / 2 - 28, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if highlitedChar == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[2]), VIRTUAL_WIDTH / 2 - 6, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if highlitedChar == 3 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[3]), VIRTUAL_WIDTH / 2 + 20, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter to Confirm!', 0, VIRTUAL_HEIGHT - 18, VIRTUAL_WIDTH, 'center')
end


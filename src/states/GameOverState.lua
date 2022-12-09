GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.score = params.score
    self.highscores = params.highscores
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local highScore = false
        local scoreIndex = 11
        for i = 10, 1, -1 do
            local score = self.highscores[i].score or 0
            if self.score > score then
                highscoreIndex = i
                highScore = true
            end
        end

        if highScore then
            gSounds['highscore']:play()
            gStateMachine:change('enterhighscore', {
                highscores = self.highscores,
                score = self.score,
                scoreIndex = highscoreIndex
            })
        else
            gStateMachine:change('start', {
                highscores = self.highscores
            })
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    --Game Over
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Game Over!', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    --Mostar Pontuaçao
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT - 50, VIRTUAL_WIDTH, 'center')
end
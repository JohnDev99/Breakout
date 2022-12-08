GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.score = params.score
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    --Game Over
    love.graphics.setFont(gFonts['huge'])
    love.graphics.printf('Game Over!', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    --Mostar Pontuaçao
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT - 50, VIRTUAL_WIDTH, 'center')
end
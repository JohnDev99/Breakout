StartState = Class{__includes = BaseState}

local highlited = 1

function StartState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlited = highlited == 1 and 2 or 1
        --som de tecla
        gSounds['paddle_hit']:play()
    end

    --encerra aplicaçao
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    --title render
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Breakout', 0,VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    --instrunctions render
    love.graphics.setFont(gFonts['medium'])
    
    --seleçao de opçoes dop menu
    if highlited == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf('Start', 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')

    --reset de cor para branco
    love.graphics.setColor(1, 1, 1, 1)

    if highlited == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf('High Scores', 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
end


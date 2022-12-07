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

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
end

function PlayState:update(dt)
    --Menu de pausa a fazer
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
    end

    self.paddle:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    self.paddle:render()

    --Desenhar o painel de pausa
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf('Paused', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end
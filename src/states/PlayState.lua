PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.ball = Ball(1)

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(50, 60)

    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT / 2 - 42
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

    --Atualiza posiçao
    self.paddle:update(dt)
    self.ball:update(dt)

    --se a bola colidiu com algo
    if self.ball:collides(self.paddle) then
        self.ball.dy = -self.ball.dy
        gSounds['paddle_hit']:play()
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    --Desenhar objetos na cena de Play
    self.paddle:render()
    self.ball:render()

    --Desenhar o painel de pausa
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf('Paused', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

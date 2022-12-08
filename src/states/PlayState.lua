PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(50, 60)
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
        --Previne que a boal entra dentro do paddle
        self.ball.y = self.paddle.y - 8
        self.ball.dy = -self.ball.dy

        --Previne que a bola deslize sobre a superficie do paddle(game bug fixed)
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end

        gSounds['paddle_hit']:play()
    end

    for k, brick in pairs(self.bricks) do
        if brick.inPlay and self.ball:collides(brick) then
            --Adicionar pontuaçao
            self.score = self.score + (brick.tier * 200 + brick.color * 25)
            brick:hit()

            --colisao do lado direito
            if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x - 8
            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                --colisao do lado esquerso
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + 32
            elseif self.ball.y < brick.y then
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - 8
            else
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y + 16
            end
            self.ball.dy = self.ball.dy * 1.02
            break
        end
    end

    --Diminuir vida se a bola passar da parte inferior do ecra
    --E voltar a servir, se ainda tiver vida
    if self.ball.y >= VIRTUAL_HEIGHT then
        self.health = self.health - 1
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change('gameover', {
                score = self.score
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                score = self.score,
                health = self.health
            })
        end
    end

    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    --Desenhar objetos na cena de Play
    self.paddle:render()
    self.ball:render()

    --Metodos para renderizar GUI
    renderScore(self.score)
    renderHealth(self.health)

    for k, brick in pairs(self.bricks) do 
        brick:render()
        --brick:renderParticleSystem()
    end

    for k, brick in pairs(self.bricks) do
        brick:renderParticleSystem()
    end


    --Desenhar o painel de pausa
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf('Paused', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

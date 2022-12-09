Paddle = Class{}

function Paddle:init(skin)
    self.x = VIRTUAL_WIDTH / 2 - 32
    self.y = VIRTUAL_HEIGHT - 32
    --movimento em x
    self.dx = 0
    --Dimensoes iniciais
    self.width = 64
    self.height = 16
    --Possiblidede de mudar de textura
    self.skin = skin
    --Tamanho do paddle inicial, havendo outros tres de diferentes dimensoes
    self.size = 2
end

function Paddle:update(dt)
    if love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED --constatnte
    elseif love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end

    --Clamp(previne que o paddle sai fora do ecra)
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Paddle:render()
    --Desenhar paddle
    love.graphics.draw(gTextures['main'], gFrames['paddles'][self.size + 4 * (self.skin - 1)], self.x, self.y)
end
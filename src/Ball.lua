Ball = Class{}

--construtor
function Ball:init(skin)
    self.width = 8
    self.height = 8

    self.dx = 0
    self.dy = 0

    --Argumento a passar no construtor
    self.skin = skin
end

function Ball:collides(target)
    --
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end
    
    --
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2

    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)
    --Atualizar posiçao da bola
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    --Bola colide com o lado esquedo da tela
    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        gSounds['wall_hit']:play()
    end

    --bola colide com o lado direito da tela
    if self.x >= VIRTUAL_WIDTH - 8 then
        self.x = VIRTUAL_WIDTH - 8
        self.dx = -self.dx
        gSounds['wall_hit']:play()
    end

    --bola colide no topo da tela
    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        gSounds['wall_hit']:play()
    end

    --se a bola colidir na parte inferior da tela, a bola nao é recocheteada
end

function Ball:render()
    love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin], self.x, self.y)
end


        
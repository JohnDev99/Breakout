Brick = Class{}

paletteColors = {
    --azul
    [1] = {
        ['r'] = 99,['g'] = 155,['b'] = 255
    },
    --verde
    [2] = {
        ['r'] = 106,['g'] = 190,['b'] = 47
    },
    --vermelho
    [3] = {
        ['r'] = 217,['g'] = 87,['b'] = 99
    },
    --purpura
    [4] = {
        ['r'] = 215,['g'] = 123,['b'] = 186
    },
    --dourado
    [5] = {
        ['r'] = 251,['g'] = 242,['b'] = 54
    }
}

function Brick:init(x, y)
    self.tier = 0
    self.color = 1

    self.x = x
    self.y = y

    self.width = 32
    self.height = 16

    self.inPlay = true

    --Sistema de Particulas
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)
    --Tempo de vida da particula apos emissao
    self.psystem:setParticleLifetime(0.5, 1)
    self.psystem:setLinearAcceleration(-15, 0, 15, 80)
    self.psystem:setEmissionArea('normal', 10, 10)
end

--Metodo de colisao
function Brick:hit()

    self.psystem:setColors(
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
        55 * (self.tier + 1) / 255,
        paletteColors[self.color].r / 255,
        paletteColors[self.color].g / 255,
        paletteColors[self.color].b / 255,
        0
    )
    self.psystem:emit(64)

    gSounds['brick_hit_2']:stop()
    gSounds['brick_hit_2']:play()

    if self.tier > 0 then
        if self.color == 0 then
            self.tier = self.tier - 1
            self.color = 5
        else
            self.color = self.color - 1
        end
    else
        if self.color == 1 then
            self.inPlay = false
        else
            self.color = self.color - 1
        end
    end

    if not self.inPlay then
        gSounds['brick_hit_1']:stop()
        gSounds['brick_hit_1']:play()
    end
end

function Brick:update(dt)
    self.psystem:update(dt)
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['bricks'][1 + ((self.color - 1) * 4) + self.tier],
        self.x, self.y)
    end
end

function Brick:renderParticleSystem()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end

    
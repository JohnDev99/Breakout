Brick = Class{}

function Brick:init(x, y)
    self.tier = 0
    self.color = 1

    self.x = x
    self.y = y

    self.width = 32
    self.height = 16

    self.inPlay = true
end

--Metodo de colisao
function Brick:hit()
    gSounds['brick_hit_1']:play()
    self.inPlay = false
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['bricks'][1 + ((self.color - 1) * 4) + self.tier],
        self.x, self.y)
    end
end

    
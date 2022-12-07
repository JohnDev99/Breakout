
function love.load()

    --Lista de tamanho de fontes
    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }
    love.graphics.setFont(gFonts['small']) --Tamanho de fonte padrao


    gTextures = {
        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['main'] = love.graphics.newImage('graphics/breakout.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
        ['particles'] = love.graphics.newImage('graphics/particle.png')
    }


    --lista de sons
    gSounds = {
        ['brick_hit_1'] = love.audio.newSource('sounds/hit.wav', 'static'),
        ['brick_hit_2'] = love.audio.newSource('sounds/brick-hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['high_score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['no_select'] = love.audio.newSource('sounds/no-select.wav', 'static'),
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit', 'static')

        ['music'] = love.audio.newSource('sounds/music.wav', 'static')
    }
end

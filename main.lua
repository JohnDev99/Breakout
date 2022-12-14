--Importar as minhas dependencias
require 'src/Dependencies'


function love.load()

    --baixa resoluçao
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --Todos os metodos random sao aleatoreos e nao constantes
    math.randomseed(os.time())

    --Titulo da tela do progama
    love.window.setTitle('Breakout')

    --Lista de tamanho de fontes
    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
        ['huge'] = love.graphics.newFont('fonts/font.ttf', 48)
    }
    love.graphics.setFont(gFonts['small']) --Tamanho de fonte padrao


    gTextures = {
        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['main'] = love.graphics.newImage('graphics/breakout.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        resizable = true,
        vsync = true,
        fullscreen = false
    })

    --lista de texturas do paddle
    gFrames = {
        ['paddles'] = GenerateQuadsPaddles(gTextures['main']),
        ['balls'] = GenerateQuadsBalls(gTextures['main']),
        ['bricks'] = GenerateQuadsBricks(gTextures['main']),
        ['hearts'] = GenerateQuads(gTextures['hearts'], 10, 9),
        ['arrows'] = GenerateQuads(gTextures['arrows'], 24, 24)
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
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),

        ['music'] = love.audio.newSource('sounds/music.wav', 'static')

        }

    --Defenir a minha maquina de estados
    gStateMachine = StateMachine{
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['serve'] = function() return ServeState() end,
        ['gameover'] = function() return GameOverState() end,
        ['victory'] = function() return VictoryState() end,
        ['highscores'] = function() return HighScoreState() end,
        ['enterhighscore'] = function() return EnterHighScoreState() end,
        ['paddleselect'] = function() return PaddleSelectState() end
    }

    gStateMachine:change('start', {
        highscores = loadHighScores()
    })

    gSounds['music']:play()
    gSounds['music']:setLooping(true)

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gStateMachine:update(dt)

    --Limpar lista de teclas primidas
    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    --Adicionar a tecla primida a tabela
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
    push:apply('start')

    --imagem vai ser renderizada em todos os estados
    local backgroundheight = gTextures['background']:getHeight()
    local backgroundwidth = gTextures['background']:getWidth()

    love.graphics.draw(gTextures['background'], 
    --coordenadas x e y
    0, 0,
    --sem rotaçao
    0,
    --Usar o fundo em toda a extensao da tela
    VIRTUAL_WIDTH / (backgroundwidth - 1), VIRTUAL_HEIGHT / (backgroundheight - 1))

    gStateMachine:render()

    displayFPS()

    push:apply('end')
end

function renderHealth(health)
    local healthX = VIRTUAL_WIDTH - 100
    --renderizar todos os meus coraçoes a partir da esquerda
    for i = 1, health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][1], healthX, 4)
        healthX = healthX + 11
    end
    --renderizar coraçoes nao preenchidos
    for i = 1, 3 - health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][2], healthX, 4)
        healthX = healthX + 11
    end
end

function renderScore(score)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Score: ', VIRTUAL_WIDTH - 60, 5)
    love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 5, 40, 'right')
end

function displayFPS()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, VIRTUAL_HEIGHT - 15) --Posiçao em x e y
end

function loadHighScores()
    love.filesystem.setIdentity('breakout')

    --caso o ficheiro ainda nao exista gerar um com valores nulos
    if not love.filesystem.getInfo('breakout.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'CT0\n'
            scores = scores .. tostring(i * 1000) .. '\n'
        end

        love.filesystem.write('breakout.lst', scores)
    end

    local name = true
    local currentName = nil
    local counter = 1

    local scores = {}

    for i = 1, 10 do
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    for line in love.filesystem.lines('breakout.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end
        name = not name
    end
    return scores 
end
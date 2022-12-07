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

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        resizable = true,
        vsync = true,
        fullscreen = false
    })


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

    --Iniciar a minha maquina de estados
    gStateMachine = StateMachine{
        ['start'] = function() return StartState() end
    }

    gStateMachine:change('start')

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

function displayFPS()
    love.graphics.setFont(small)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.printf('FPS: ' .. tostring(love.timer.getFPS()), 5, 5) --Posiçao em x e y
end
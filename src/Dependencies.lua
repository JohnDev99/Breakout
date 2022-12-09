--Classe para guardar todos os diretorios das minha librarias a usar
push = require 'lib/push'
Class = require 'lib/class'

require 'src/constants'

require 'src/StateMachine'

require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/ServeState'
require 'src/states/GameOverState'
require 'src/states/VictoryState'
require 'src/states/HighScoreState'
require 'src/states/EnterHighScoreState'
require 'src/states/PaddleSelectState'

require 'src/Util'
require 'src/Paddle'
require 'src/Ball'
require 'src/Brick'
require 'src/LevelMaker'
-- Import OOP library middleclass
local class = require 'middleclass'

local enemyActionDecision = require 'enemyAI'
local enemyAI = EnemyAI:new()

-- Inheritance
local parent = require 'actor'

Enemy = class('Enemy', Actor)

function Enemy:initialize(actorType, xPos, yPos, energyThreshold, hp)
    Actor.initialize(self, actorType, xPos, yPos, energyThreshold, hp)

    if self.actorType == 'snake' then
        self.img = love.graphics.newImage('assets/snake.png')
    end

    -- Add new actor to table of actors
    table.insert(gameActors, self)
    id = id + 1
end

-- TODO Display enemy health if it is less than max

function Enemy:takeAction()
    self.energy = self.energy + 1

    -- Turn speed system
    if self.energy >= self.energyThreshold then

        -- Store current xPos and yPos
        pastXPos, pastYPos = self.xPos, self.yPos

        self.xPos, self.yPos = enemyAI:getDecision(self.xPos, self.yPos, self.damage)

        -- Mark previous square as empty
        gameBoard[pastXPos + (pastYPos - 1) * gameBoardWidth] = 0

        -- Update gameBoard with position of game actor
        gameBoard[self.xPos + (self.yPos - 1) * gameBoardWidth] = 'enemy'

        -- Update actor's tileIndexPosition
        self.tileIndexPos = self.xPos + (self.yPos - 1) * gameBoardWidth

        -- Subtract actor energy
        self.energy = self.energy - self.energyThreshold
    end
end

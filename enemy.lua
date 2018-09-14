-- Import OOP library middleclass
local class = require 'middleclass'
local decision = require 'randomWalkDecision'
local RandomWalkDecision = RandomWalkDecision:new()

-- Command actions
local action1 = require 'walkaction'
local walk = WalkAction:new()

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

function Enemy:takeAction()
    self.energy = self.energy + 1

    -- Turn speed system
    if self.energy >= self.energyThreshold then

        -- Store current xPos and yPos
        pastXPos, pastYPos = self.xPos, self.yPos

        -- Get random direction to walk to
        local input = RandomWalkDecision:getRandomDirection(self.xPos, self.yPos)

        -- Walk that direction
        self.xPos, self.yPos = walk:walk(self.xPos, self.yPos, input)

        -- Mark previous square as empty
        gameBoard[pastXPos + (pastYPos - 1) * gameBoardWidth] = 0

        -- Update gameBoard with position of game actor
        gameBoard[self.xPos + (self.yPos - 1) * gameBoardWidth] = 1

        -- Subtract actor energy
        self.energy = self.energy - self.energyThreshold
    end
end

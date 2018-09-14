-- Import OOP library middleclass
local class = require 'middleclass'

-- Command actions
local action1 = require 'walkaction'
local walk = WalkAction:new()

-- Inheritance
local parent = require 'actor'

Player = class('Player', Actor)

function Player:initialize(actorType, xPos, yPos, energyThreshold, hp)
    Actor.initialize(self, actorType, xPos, yPos, energyThreshold, hp)

    -- Add new actor to table of actors
    table.insert(gameActors, self)
    id = id + 1
end

function Player:takeAction()
    self.energy = self.energy + 1
    -- Turn speed system
    if self.energy >= self.energyThreshold then

        pastXPos, pastYPos = self.xPos, self.yPos

        -- If player can't move with current input ask for new input
        -- if(walk:walk(self.xPos, self.yPos, self.input) == 'playerCannotMove') then
        --     return 'playerCannotMove'
        -- end

        self.xPos, self.yPos = walk:walk(self.xPos, self.yPos, self.input)

        -- Mark previous square as empty
        gameBoard[pastXPos + (pastYPos - 1) * gameBoardWidth] = 0

        -- Update gameBoard with position of game actor
        gameBoard[self.xPos + (self.yPos - 1) * gameBoardWidth] = 1

        -- Subtract actor energy
        self.energy = self.energy - self.energyThreshold
    end
end
-- Import OOP library middleclass
local class = require 'middleclass'

-- Command actions
local action1 = require 'walkaction'
local walk = WalkAction:new()


Actor = class('Actor')

local id = 0


function Actor:initialize(actorType, xPos, yPos, energyThreshold, hp)
    self.actorType = actorType
    self.xPos = xPos
    self.yPos = yPos
    self.energyThreshold = energyThreshold
    self.hp = hp
    self.energy = 0
    self.input = nil
    self.id = id

    if self.actorType == 'snake' then
        self.img = love.graphics.newImage('assets/snake.png')
    end

    -- Add new actor to table of actors
    table.insert(gameActors, self)
    id = id + 1
end

-- TODO Make player a inherited class of Actor
-- TODO Make an enemy that moves towards player
-- TODO Add attack action for Actors, Players, and Enemies
-- Keep initialize function same, change action choice logic
-- Use same command actions

function Actor:takeAction()
    self.energy = self.energy + 1
    -- Turn speed system
    if self.energy >= self.energyThreshold then

        pastXPos, pastYPos = self.xPos, self.yPos
        -- If player can't move with current input
        if(walk:walk(self.xPos, self.yPos, self.input) == 'playerCannotMove') then
            return 'playerCannotMove'
        end

        self.xPos, self.yPos = walk:walk(self.xPos, self.yPos, self.input)

        -- Mark previous square as empty
        gameBoard[pastXPos + (pastYPos - 1) * gameBoardWidth] = 0

        -- Update gameBoard with position of game actor
        gameBoard[self.xPos + (self.yPos - 1) * gameBoardWidth] = 1

        -- Subtract actor energy
        self.energy = self.energy - self.energyThreshold
        return nil
    end
end

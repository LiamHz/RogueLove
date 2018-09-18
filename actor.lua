-- Import OOP library middleclass
local class = require 'middleclass'

Actor = class('Actor')

local id = 0

function Actor:initialize(xPos, yPos)
    self.xPos = xPos
    self.yPos = yPos
    self.energy = 0
    self.input = nil
    self.id = id
    self.img = nil
    self.tileIndexPos = self.xPos + (self.yPos - 1) * gameBoardWidth

    -- Add new actor to table of actors
    table.insert(gameActors, self)
    id = id + 1
end

-- TODO Make a new enemy child that always moves towards player using BFS (energyThreshold = 2)


-- function Actor:takeAction(actorType)
--     self.energy = self.energy + 1
--
--     -- Turn speed system
--     if self.energy >= self.energyThreshold then
--
--         -- Store current xPos and yPos
--         pastXPos, pastYPos = self.xPos, self.yPos
--
--         ::getEnemyDecision::
--         print(self.actorType)
--
--         self.xPos, self.yPos, actorCannotMove = SnakeAI:getDecision(self.xPos, self.yPos, self.damage, self.actionIndex)
--
--         if actorCannotMove == true then
--             goto getEnemyDecision
--         end
--
--         -- Mark previous square as empty
--         gameBoard[pastXPos + (pastYPos - 1) * gameBoardWidth] = 0
--
--         -- Update gameBoard with position of game actor
--         gameBoard[self.xPos + (self.yPos - 1) * gameBoardWidth] = 'enemy'
--
--         -- Update actor's tileIndexPosition
--         self.tileIndexPos = self.xPos + (self.yPos - 1) * gameBoardWidth
--
--         -- Subtract actor energy
--         self.energy = self.energy - self.energyThreshold
--     end
--
--     return false
-- end

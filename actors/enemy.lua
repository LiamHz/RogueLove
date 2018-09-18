-- Import OOP library middleclass
local class = require 'lib.middleclass'

-- Inheritance
local parent = require 'actors.actor'

Enemy = class('Enemy', Actor)

function Enemy:initialize(xPos, yPos)
    Actor.initialize(self, xPos, yPos)

    self.actionIndex = 0

    -- Mark actor's gameboard square as occupied
    gameBoard[self.tileIndexPos] = 'enemy'
end

-- function Enemy:takeAction()
--     self.energy = self.energy + 1
--
--     -- Turn speed system
--     if self.energy >= self.energyThreshold then
--
--         -- Store current xPos and yPos
--         pastXPos, pastYPos = self.xPos, self.yPos
--
--         ::getEnemyDecision::
--
--         self.xPos, self.yPos, actorCannotMove = enemyAI:getDecision(self.xPos, self.yPos, self.damage)
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

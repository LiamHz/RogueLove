-- Import OOP library middleclass
local class = require 'middleclass'

-- Command actions
local action1 = require 'walkaction'
local action2 = require 'attackaction'

-- Inheritance
local parent = require 'actor'

Enemy = class('Enemy', Actor)

function Enemy:initialize(xPos, yPos)
    Actor.initialize(self, xPos, yPos)

    -- Mark actor's gameboard square as occupied
    gameBoard[self.tileIndexPos] = 'enemy'

    self.actionIndex = 0
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
--         print(self.actorType)
--
--         if self.actorType == 'snake' then
--             self.xPos, self.yPos, actorCannotMove = SnakeAI:getDecision(self.xPos, self.yPos, self.damage, self.actionIndex)
--             self.actionIndex = (self.actionIndex + 1) % 2
--         end
--
--         -- self.xPos, self.yPos, actorCannotMove = EnemyAI:getDecision(self.xPos, self.yPos, self.damage)
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

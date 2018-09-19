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

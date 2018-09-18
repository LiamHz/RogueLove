-- Import OOP library middleclass
local class = require 'middleclass'

local playerDecision = require 'playerDecision'
local PlayerDecision = PlayerDecision:new()

-- Inheritance
local parent = require 'actor'

Player = class('Player', Actor)

function Player:initialize(xPos, yPos)
    Actor.initialize(self, xPos, yPos)

    self.actorType = 'player'
    self.energyThreshold = 1
    self.hp = 3
    self.damage = 1

    -- Used to keep player centered with camera
    self.distanceFromCenterHorizontal = 0
    self.distanceFromCenterVertical = 0

    -- Mark actor's gameboard square as occupied
    gameBoard[self.tileIndexPos] = 'player'
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

        self.xPos, self.yPos, actorCannotMove, self.distanceFromCenterVertical, self.distanceFromCenterHorizontal
            = PlayerDecision:getDecision(self.xPos, self.yPos, self.distanceFromCenterVertical, self.distanceFromCenterHorizontal, self.damage, self.input)

        -- Ask for new user input if player couldn't move
        -- i.e. walked into a wall
        if actorCannotMove == true then
            return actorCannotMove
        end

        -- Mark previous square as empty
        gameBoard[pastXPos + (pastYPos - 1) * gameBoardWidth] = 0

        -- Update gameBoard with position of game actor
        gameBoard[self.xPos + (self.yPos - 1) * gameBoardWidth] = 'player'

        -- Update actor's tileIndexPosition
        self.tileIndexPos = self.xPos + (self.yPos - 1) * gameBoardWidth

        -- Subtract actor energy
        self.energy = self.energy - self.energyThreshold
    end

    return false
end

-- Enemy that moves randomly. Will attack player if they are adjacent
-- Moves every other turn

-- Import OOP library middleClass
local class = require 'lib.middleclass'

-- Actions
local attack = require 'actions.attackAction'
local randomMove = require 'actions.randomMoveDecision'

-- Inheritance
Elephant = class('Elephant', Enemy)

function Elephant:initialize(xPos, yPos)
    Enemy.initialize(self, xPos, yPos)

    self.actorType = 'elephant'
    self.hp = 1
    self.energyThreshold = 2
    self.damage = 1

    self.img = love.graphics.newImage('assets/elephant.png')
end

function Elephant:takeAction()
    self.energy = self.energy + 1

    -- Turn speed system
    if self.energy >= self.energyThreshold then

        -- Store current xPos and yPos
        pastXPos, pastYPos = self.xPos, self.yPos

        ::getEnemyDecision::

        self:getDecision()

        -- if actorCannotMove == true then
        --     goto getEnemyDecision
        -- end

        -- Mark previous square as empty
        gameBoard[pastXPos + (pastYPos - 1) * gameBoardWidth] = 0

        -- Update gameBoard with position of game actor
        gameBoard[self.xPos + (self.yPos - 1) * gameBoardWidth] = 'enemy'

        -- Update actor's tileIndexPosition
        self.tileIndexPos = self.xPos + (self.yPos - 1) * gameBoardWidth

        -- Subtract actor energy
        self.energy = self.energy - self.energyThreshold
    end

    return false
end

function Elephant:getDecision(xPos, yPos, damage)
    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = self.xPos + (self.yPos - 1) * gameBoardWidth

    -- If elephant can attack player, attack
    if (gameBoard[tileIndex - gameBoardWidth] == 'player') then
        targetPos = tileIndex - gameBoardWidth
        AttackAction:attack(targetPos, self.damage)
    elseif (gameBoard[tileIndex + gameBoardWidth] == 'player') then
        targetPos = tileIndex + gameBoardWidth
        AttackAction:attack(targetPos, self.damage)
    elseif (gameBoard[tileIndex - 1] == 'player') then
        targetPos = tileIndex - 1
        AttackAction:attack(targetPos, self.damage)
    elseif (gameBoard[tileIndex + 1] == 'player') then
        targetPos = tileIndex + 1
        AttackAction:attack(targetPos, self.damage)
    else
        -- Get random direction to move to
        local input = RandomMoveDecision:getRandomMove(self.xPos, self.yPos)

        -- Move that direction
        self.xPos, self.yPos = WalkAction:walk(self.xPos, self.yPos, input)
    end
end

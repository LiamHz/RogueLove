-- Enemy that moves in a clockwise pattern

-- Import OOP library middleclass
local class = require 'lib.middleclass'

-- Inheritance
local parent = require 'actors.enemy'

Monkey = class('Monkey', Enemy)

function Monkey:initialize(xPos, yPos)
    Enemy.initialize(self, xPos, yPos)

    self.actorType = 'monkey'
    self.hp = 1
    self.energyThreshold = 1
    self.damage = 1

    self.img = love.graphics.newImage('assets/monkey.png')
end

function Monkey:takeAction()
    self.energy = self.energy + 1

    -- Turn speed system
    if self.energy >= self.energyThreshold then

        -- Store current xPos and yPos
        pastXPos, pastYPos = self.xPos, self.yPos

        self:getDecision()

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

function Monkey:getDecision()
    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = self.xPos + (self.yPos - 1) * gameBoardWidth

    -- Move up-right
    if self.actionIndex == 0 then
        if (gameBoard[tileIndex - gameBoardWidth + 1] == 'player') then
            targetPos = tileIndex - gameBoardWidth + 1
            AttackAction:attack(targetPos, self.damage)
        elseif (gameBoard[tileIndex - gameBoardWidth + 1] == 0) then
            self.xPos, self.yPos, self.actorCannotMove = WalkAction:walk(self.xPos, self.yPos, 'up-right')
            self.actionIndex = (self.actionIndex + 1) % 4
        else
            self.actionIndex = (self.actionIndex + 1) % 2
        end
    -- Move down-right
    elseif self.actionIndex == 1 then
        if (gameBoard[tileIndex + gameBoardWidth + 1] == 'player') then
            targetPos = tileIndex + gameBoardWidth + 1
            AttackAction:attack(targetPos, self.damage)
        elseif (gameBoard[tileIndex + gameBoardWidth + 1] == 0) then
            self.xPos, self.yPos, self.actorCannotMove = WalkAction:walk(self.xPos, self.yPos, 'down-right')
            self.actionIndex = (self.actionIndex + 1) % 4
        else
            self.actionIndex = (self.actionIndex + 1) % 2
        end
    -- Move down-left
    elseif self.actionIndex == 2 then
        if (gameBoard[tileIndex + gameBoardWidth - 1] == 'player') then
            targetPos = tileIndex + gameBoardWidth - 1
            AttackAction:attack(targetPos, self.damage)
        elseif (gameBoard[tileIndex + gameBoardWidth - 1] == 0) then
            self.xPos, self.yPos, self.actorCannotMove = WalkAction:walk(self.xPos, self.yPos, 'down-left')
            self.actionIndex = (self.actionIndex + 1) % 4
        else
            self.actionIndex = (self.actionIndex + 1) % 2
        end
    -- Move up-left
    elseif self.actionIndex == 3 then
        if (gameBoard[tileIndex - gameBoardWidth - 1] == 'player') then
            targetPos = tileIndex - gameBoardWidth - 1
            AttackAction:attack(targetPos, self.damage)
        elseif (gameBoard[tileIndex - gameBoardWidth - 1] == 0) then
            self.xPos, self.yPos, self.actorCannotMove = WalkAction:walk(self.xPos, self.yPos, 'up-left')
            self.actionIndex = (self.actionIndex + 1) % 4
        else
            self.actionIndex = (self.actionIndex + 1) % 2
        end
    end
end

-- Enemy that alternates moving up or down

-- Import OOP library middleclass
local class = require 'lib.middleclass'

-- Inheritance
local parent = require 'actors.enemy'

Snake = class('Snake', Enemy)

function Snake:initialize(xPos, yPos)
    Enemy.initialize(self, xPos, yPos)

    self.actorType = 'snake'
    self.hp = 1
    self.energyThreshold = 2
    self.damage = 1

    self.img = love.graphics.newImage('assets/snake.png')
end

function Snake:takeAction()
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

function Snake:getDecision()
    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = self.xPos + (self.yPos - 1) * gameBoardWidth

    -- Move up
    if self.actionIndex == 0 then
        if (gameBoard[tileIndex - gameBoardWidth] == 'player') then
            targetPos = tileIndex - gameBoardWidth
            AttackAction:attack(targetPos, self.damage)
        elseif (gameBoard[tileIndex - gameBoardWidth] == 0) then
            self.xPos, self.yPos, self.actorCannotMove = WalkAction:walk(self.xPos, self.yPos, 'up')
            self.actionIndex = (self.actionIndex + 1) % 2
        end
    -- Move down
    elseif self.actionIndex == 1 then
        if (gameBoard[tileIndex + gameBoardWidth] == 'player') then
            targetPos = tileIndex + gameBoardWidth
            AttackAction:attack(targetPos, self.damage)
        elseif (gameBoard[tileIndex + gameBoardWidth] == 0) then
            self.xPos, self.yPos, self.actorCannotMove = WalkAction:walk(self.xPos, self.yPos, 'down')
            self.actionIndex = (self.actionIndex + 1) % 2
        end
    end
end

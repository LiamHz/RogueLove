-- Import OOP library middleclass
local class = require 'middleclass'
local randomDecision = require 'randomWalkDecision'

-- Command actions
local action1 = require 'walkaction'
local action2 = require 'attackaction'

EnemyAI = class('EnemyAI')

function EnemyAI:initialize()
    self.name = 'EnemyAI'
end

function EnemyAI:getDecision(xPos, yPos)

    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = xPos + (yPos - 1) * gameBoardWidth
    local direction = nil

    if (gameBoard[tileIndex - gameBoardWidth] == 'player') then
        direction = 'up'
    elseif (gameBoard[tileIndex + gameBoardWidth] == 'player') then
        direction = 'down'
    elseif (gameBoard[tileIndex - 1] == 'player') then
        direction = 'left'
    elseif (gameBoard[tileIndex + 1] == 'player') then
        direction = 'right'
    else
        -- Get random direction to walk to
        local input = RandomWalkDecision:getRandomDirection(xPos, yPos)

        -- Walk that direction
        xPos, yPos = WalkAction:walk(xPos, yPos, input)

        return xPos, yPos
    end

    AttackAction:attack(direction)
    return xPos, yPos
end

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

function EnemyAI:getDecision(xPos, yPos, damage)

    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = xPos + (yPos - 1) * gameBoardWidth
    local direction = nil

    if (gameBoard[tileIndex - gameBoardWidth] == 'player') then
        targetPos = tileIndex - gameBoardWidth
        AttackAction:attack(targetPos, damage)
    elseif (gameBoard[tileIndex + gameBoardWidth] == 'player') then
        targetPos = tileIndex + gameBoardWidth
        AttackAction:attack(targetPos, damage)
    elseif (gameBoard[tileIndex - 1] == 'player') then
        targetPos = tileIndex - 1
        AttackAction:attack(targetPos, damage)
    elseif (gameBoard[tileIndex + 1] == 'player') then
        targetPos = tileIndex + 1
        AttackAction:attack(targetPos, damage)
    else
        -- Get random direction to walk to
        local input = RandomWalkDecision:getRandomDirection(xPos, yPos)

        -- Walk that direction
        xPos, yPos, actorCannotMove = WalkAction:walk(xPos, yPos, input)
    end

    return xPos, yPos, actorCannotMove
end

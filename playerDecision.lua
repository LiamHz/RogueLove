-- Import OOP library middleclass
local class = require 'middleclass'

-- Command actions
local action1 = require 'walkaction'
local action2 = require 'attackaction'

PlayerDecision = class('PlayerDecision')

function PlayerDecision:initialize()
    self.name = 'PlayerDecision'
end

function PlayerDecision:getDecision(xPos, yPos, input)

    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = xPos + (yPos - 1) * gameBoardWidth

    if (input == 'up') and (gameBoard[tileIndex - gameBoardWidth] == 'enemy') then
        direction = 'up'
    elseif (input == 'down') and (gameBoard[tileIndex + gameBoardWidth] == 'enemy') then
        direction = 'down'
    elseif (input == 'left') and (gameBoard[tileIndex - 1] == 'enemy') then
        direction = 'left'
    elseif (input == 'right') and (gameBoard[tileIndex + 1] == 'enemy') then
        direction = 'right'
    else

        -- Walk the direction of input
        xPos, yPos = WalkAction:walk(xPos, yPos, input)

        return xPos, yPos
    end

    AttackAction:attack(direction)
    return xPos, yPos
end

-- Import OOP library middleclass
local class = require 'middleclass'

-- Command actions
local action1 = require 'walkaction'
local action2 = require 'attackaction'

PlayerDecision = class('PlayerDecision')

function PlayerDecision:initialize()
    self.name = 'PlayerDecision'
end

function PlayerDecision:getDecision(xPos, yPos, damage, input)

    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = xPos + (yPos - 1) * gameBoardWidth

    if (input == 'up') and (gameBoard[tileIndex - gameBoardWidth] == 'enemy') then
        targetPos = tileIndex - gameBoardWidth
        AttackAction:attack(targetPos, damage)
    elseif (input == 'down') and (gameBoard[tileIndex + gameBoardWidth] == 'enemy') then
        targetPos = tileIndex + gameBoardWidth
        AttackAction:attack(targetPos, damage)
    elseif (input == 'left') and (gameBoard[tileIndex - 1] == 'enemy') then
        targetPos = tileIndex - 1
        AttackAction:attack(targetPos, damage)
    elseif (input == 'right') and (gameBoard[tileIndex + 1] == 'enemy') then
        targetPos = tileIndex + 1
        AttackAction:attack(targetPos, damage)
    else
        -- Walk the direction of input
        xPos, yPos, actorCannotMove = WalkAction:walk(xPos, yPos, input)

        -- Move camera to keep player centered
        if actorCannotMove == false then
            if input == 'up' then
                Camera:move(0, -tileHeight * tileHeightScaleFactor)
            elseif input == 'down' then
                Camera:move(0, tileHeight * tileHeightScaleFactor)
            elseif input == 'left' then
                Camera:move(-tileWidth * tileWidthScaleFactor, 0)
            elseif input == 'right' then
                Camera:move(tileWidth * tileWidthScaleFactor, 0)
            end
        end
    end

    return xPos, yPos, actorCannotMove
end

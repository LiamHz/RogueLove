-- Import OOP library middleclass
local class = require 'core.middleclass'

RandomWalkDecision = class('RandomWalkDecision')

function RandomWalkDecision:initialize()
    self.name = 'RandomWalk'
end

function RandomWalkDecision:getRandomDirection(xPos, yPos)
    local direction = nil
    local rand = love.math.random()

    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = xPos + (yPos - 1) * gameBoardWidth

    if (yPos > 1) and (rand < 0.25) then
        -- Check for obstacle collision; gameBoard index = 0
        -- indicates empty space
        if (gameBoard[tileIndex - gameBoardWidth] == 0) then
            direction = 'up'
        end
    elseif (yPos < gameBoardHeight) and (rand < 0.5) then
        if (gameBoard[tileIndex + gameBoardWidth] == 0) then
            direction = 'down'
        end
    elseif (xPos > 1) and (rand < 0.75)  then
        if (gameBoard[tileIndex - 1] == 0) then
            direction = 'left'
        end
    elseif (xPos < gameBoardWidth) then
        if (gameBoard[tileIndex + 1] == 0) then
            direction = 'right'
        end
    else
        -- print("Enemy couldn't move")
        direction = 'none'
    end

    return direction
end

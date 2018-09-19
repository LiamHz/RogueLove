-- Import OOP library middleclass
local class = require 'lib.middleclass'

RandomMoveDecision = class('RandomMoveDecision')

function RandomMoveDecision:initialize()
    self.name = 'RandomMove'
end

function RandomMoveDecision:getRandomMove(xPos, yPos, jk)
    local direction = nil
    local rand = love.math.random()

    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = xPos + (yPos - 1) * gameBoardWidth

    -- Check for obstacle collision; gameBoard index = 0
    -- indicates empty space
    if (rand < 0.25) and (gameBoard[tileIndex - gameBoardWidth] == 0) then
        direction = 'up'
    elseif (rand < 0.5) and (gameBoard[tileIndex + gameBoardWidth] == 0) then
        direction = 'down'
    elseif (rand < 0.75)  and (gameBoard[tileIndex - 1] == 0) then
        direction = 'left'
    elseif (rand <= 1) and (gameBoard[tileIndex + 1] == 0) then
        direction = 'right'
    end

    return direction
end

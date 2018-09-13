-- Import OOP library middleclass
local class = require 'middleclass'
-- local class = require 'actor'

WalkAction = class('WalkAction')

function WalkAction:initialize()
    self.name = 'walk'
end

function WalkAction:walk(xPos, yPos, input)

    -- Player movement
    if input ~= nil then
        if (input == 'up') and (yPos > 1) then
            yPos = yPos - 1
        elseif (input == 'down') and (yPos < gameBoardHeight) then
            yPos = yPos + 1
        elseif (input == 'left') and (xPos > 1) then
            xPos = xPos - 1
        elseif (input == 'right') and (xPos < gameBoardWidth) then
            xPos = xPos + 1
        else
            print("Invalid userInput for walk(). Received: " .. input)
            local canMove = 'playerCannotMove'
            return canMove
        end

    -- Random enemy movement
    elseif input == nil then
        local rand = love.math.random()

        -- Tile index is a single number from 0 to GB Height * GB Width
        local tileIndex = xPos + (yPos - 1) * gameBoardWidth

        if (yPos > 1) and (rand < 0.25) then
            -- Check for obstacle collision; gameBoard index <= 1
            -- indicates presence of obstacle
            if (gameBoard[tileIndex - gameBoardWidth] == 0) then
                -- Move up
                yPos = yPos - 1
            end
        elseif (yPos < gameBoardHeight) and (rand < 0.5) then
            -- Move down
            if (gameBoard[tileIndex + gameBoardWidth] == 0) then
                yPos = yPos + 1
            end
        elseif (xPos > 1) and (rand < 0.75)  then
            if (gameBoard[tileIndex - 1] == 0) then
                -- Move left
                xPos = xPos - 1
            end
        elseif (xPos < gameBoardWidth) then
            if (gameBoard[tileIndex + 1] == 0) then
                -- Move right
                xPos = xPos + 1
            end
        else
            print("Enemy couldn't move")
        end
    end

    return xPos, yPos
end

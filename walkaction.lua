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
        end

    -- Random enemy movement
    elseif input == nil then
        rand = math.random()

        -- TODO Check for obstacle collision
        if (yPos > 1) and (rand < 0.25) then
            -- if (gameBoard[xPos - yPos * gameBoardWidth] > 0) then          -- Move up
                yPos = yPos - 1
            -- end
        elseif (yPos < gameBoardHeight) and (rand < 0.5) then
            -- if (gameBoard[xPos + yPos * gameBoardWidth * 2] > 0) then      -- Move down
                yPos = yPos + 1
            -- end
        elseif (xPos > 1) and (rand < 0.75)  then
            -- if (gameBoard[xPos - 1 + yPos * gameBoardWidth] > 0) then      -- Move left
                xPos = xPos - 1
            -- end
        elseif (xPos < gameBoardWidth) then
            -- if (gameBoard[xPos + 1 + yPos * gameBoardWidth] > 0) then      -- Move right
                xPos = xPos + 1
            -- end
        else
            print("Enemy couldn't move")
        end
    end

    return xPos, yPos
end

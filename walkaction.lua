-- Import OOP library middleclass
local class = require 'middleclass'

WalkAction = class('WalkAction')

function WalkAction:initialize()
    self.name = 'walk'
end

function WalkAction:walk(xPos, yPos, input)

    if (input == 'up') and (yPos > 1) then
        yPos = yPos - 1
    elseif (input == 'down') and (yPos < gameBoardHeight) then
        yPos = yPos + 1
    elseif (input == 'left') and (xPos > 1) then
        xPos = xPos - 1
    elseif (input == 'right') and (xPos < gameBoardWidth) then
        xPos = xPos + 1
    elseif (input == 'none') then
        -- print("Invalid userInput for walk(). Received: " .. input)
        -- local canMove = 'playerCannotMove'
        -- return canMove
        print('No input')
    end

    return xPos, yPos
end

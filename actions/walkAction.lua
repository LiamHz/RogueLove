-- Import OOP library middleclass
local class = require 'lib.middleclass'

WalkAction = class('WalkAction')

function WalkAction:initialize()
    self.name = 'walk'
end

function WalkAction:walk(xPos, yPos, input)
    local actorCannotMove = false

    if (input == 'up') and (yPos > 1) then
        yPos = yPos - 1
    elseif (input == 'down') and (yPos < gameBoardHeight) then
        yPos = yPos + 1
    elseif (input == 'left') and (xPos > 1) then
        xPos = xPos - 1
    elseif (input == 'right') and (xPos < gameBoardWidth) then
        xPos = xPos + 1
    else
        print("Actor cannot move, asking for new input")
        actorCannotMove = true
    end

    return xPos, yPos, actorCannotMove
end

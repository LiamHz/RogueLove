-- Import OOP library middleclass
local class = require 'middleclass'

Actor = class('Actor')

id = 0

function Actor:initialize(actorType, xPos, yPos, energyThreshold, hp)
    self.actorType = actorType
    self.xPos = xPos
    self.yPos = yPos
    self.energyThreshold = energyThreshold
    self.hp = hp
    self.energy = 0
    self.input = nil
    self.id = id
    self.img = nil
end

-- TODO Make a new type of enemy that always moves towards player (energyThreshold = 2)

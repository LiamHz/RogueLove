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
    self.damage = 1
    self.tileIndexPos = self.xPos + (self.yPos - 1) * gameBoardWidth
end

-- TODO Make a new enemy child that always moves towards player using BFS (energyThreshold = 2)

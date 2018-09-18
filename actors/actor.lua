-- Import OOP library middleclass
local class = require 'core.middleclass'

-- Command actions
local action1 = require 'actions.walkaction'
local action2 = require 'actions.attackaction'

Actor = class('Actor')

id = 0

function Actor:initialize(xPos, yPos)
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


    -- Add new actor to table of actors
    table.insert(gameActors, self)
    id = id + 1
end

-- TODO Make a new enemy child that always moves towards player using BFS (energyThreshold = 2)

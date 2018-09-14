-- Import OOP library middleclass
local class = require 'middleclass'

-- Command actions
local action1 = require 'walkaction'
local walk = WalkAction:new()


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

-- TODO Make an enemy that moves towards player
-- TODO Add attack action for Actors, Players, and Enemies
-- Keep initialize function same, change action choice logic
-- Use same command actions

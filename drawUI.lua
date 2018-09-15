-- Import OOP library middleclass
local class = require 'middleclass'

DrawUI = class('DrawUI')

function DrawUI:initialize()
    self.name = 'DrawUI'
end

function DrawUI:drawUI(heartIcon, playerHealth)
    local screenWidth =  love.graphics.getWidth()

    -- Add gap between heart icons
    local heartWidth = heartIcon:getWidth() + 10
    local heartHeight = heartIcon:getHeight() + 10
    local numHeartsRow = 3

    for heart = 1, playerHealth do
        love.graphics.draw(heartIcon, screenWidth - (heartWidth * numHeartsRow * math.ceil(heart / numHeartsRow)) + (heartWidth * (heart - 1)) - 30,
                            math.ceil(heart / numHeartsRow) * (heartHeight) - 100)
    end
end

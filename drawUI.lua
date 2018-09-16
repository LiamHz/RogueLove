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

function DrawUI:hideEdges()
    -- Hide gameBoard parts that should not be displayed
    love.graphics.setColor(0, 0, 0)
    -- Left side
    love.graphics.rectangle('fill', 0, 0,
                            (screenWidth - gameBoardScreenDisplayWidth) / 2 + screenOffsetX / 2, screenHeight)
    -- Right side
    love.graphics.rectangle('fill',
                            (screenWidth - gameBoardScreenDisplayWidth) / 2 + gameBoardScreenDisplayWidth - screenOffsetX / 2, 0,
                            (screenWidth - gameBoardScreenDisplayWidth) / 2 + screenOffsetX / 2, screenHeight)


    -- Hide screen offsets
    -- Top
    love.graphics.rectangle('fill', 0, 0, screenWidth, screenOffsetY / 2)
    -- Bottom
    love.graphics.rectangle('fill', 0, screenHeight - screenOffsetY / 2, screenWidth, screenOffsetY / 2)


    -- Make edges of board semi opaque
    love.graphics.setColor(0, 0, 0, 0.75)
    -- Top
    love.graphics.rectangle('fill', 0, screenOffsetY / 2, screenWidth,
                            tileHeight * tileHeightScaleFactor)
    -- Bottom
    love.graphics.rectangle('fill', 0, screenHeight - screenOffsetY / 2 - tileHeight * tileHeightScaleFactor,
                            screenWidth, tileHeight * tileHeightScaleFactor)
    -- Left
    love.graphics.rectangle('fill', (screenWidth - gameBoardScreenDisplayWidth) / 2 + screenOffsetX / 2, 0,
                                    tileWidth * tileWidthScaleFactor, screenHeight)
    -- Right
    love.graphics.rectangle('fill', (screenWidth - gameBoardScreenDisplayWidth) / 2 + gameBoardScreenDisplayWidth - screenOffsetX / 2 - tileWidth * tileWidthScaleFactor, 0,
                                    tileWidth * tileWidthScaleFactor, screenHeight)


    -- Reset LOVE colors to default
    love.graphics.setColor(255, 255, 255, 255)
end

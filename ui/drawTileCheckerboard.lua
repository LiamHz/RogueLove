-- Import OOP library middleclass
local class = require 'core.middleclass'

DrawTileCheckerboard = class('DrawTileCheckerboard')

function DrawTileCheckerboard:initialize(tileSheet, tile1, tile2, tileHeight, tileWidth, tileHeightScaleFactor, tileWidthScaleFactor)
    self.name = 'DrawTileCheckerboard'
    self.tileSheet = tileSheet
    self.tile1 = tile1
    self.tile2 = tile2
    self.tileHeight = tileHeight
    self.tileWidth = tileWidth
    self.tileHeightScaleFactor = tileHeightScaleFactor
    self.tileWidthScaleFactor = tileWidthScaleFactor

    -- Used to center tiles
    self.heightWidthDelta = 0
end

function DrawTileCheckerboard:drawCheckerboard()
    for tile in ipairs(gameBoard) do

        -- -- Color one odd row
        if (tile % 2 == 0) and (math.floor((tile - 1) / gameBoardWidth) % 2 == 0) then
            love.graphics.draw(self.tileSheet, self.tile1, self.tileWidth * self.tileWidthScaleFactor * (tile % (gameBoardWidth) + 1),
                                self.tileHeight * self.tileHeightScaleFactor * math.ceil(tile / gameBoardWidth - 1) + screenOffsetY / 2,
                                0, self.tileWidthScaleFactor, self.tileHeightScaleFactor)

        -- Color one even row
        elseif (tile % 2 == 1) and (math.ceil(tile / gameBoardWidth) % 2 == 0) then
            love.graphics.draw(self.tileSheet, self.tile1, self.tileWidth * self.tileWidthScaleFactor * (tile % (gameBoardWidth) - 1),
                                self.tileHeight * self.tileHeightScaleFactor * math.ceil(tile / gameBoardWidth - 1) + screenOffsetY / 2,
                                0, self.tileWidthScaleFactor, self.tileHeightScaleFactor)

        -- Color two odd row
        elseif (tile % 2 == 1) and (math.floor((tile - 1) / gameBoardWidth) % 2 == 0) then
            -- print(self.tileWidth)
            love.graphics.draw(self.tileSheet, self.tile2, self.tileWidth * self.tileWidthScaleFactor * (tile % (gameBoardWidth) - 1),
                                self.tileHeight * self.tileHeightScaleFactor * math.ceil(tile / gameBoardWidth - 1) + screenOffsetY / 2,
                                0, self.tileWidthScaleFactor, self.tileHeightScaleFactor)
        -- color two even row
        elseif (tile % 2 == 0) and (math.ceil(tile / gameBoardWidth) % 2 == 0) then
            love.graphics.draw(self.tileSheet, self.tile2, self.tileWidth * self.tileWidthScaleFactor * (tile % (gameBoardWidth) + 1),
                                self.tileHeight * self.tileHeightScaleFactor * math.ceil(tile / gameBoardWidth - 1) + screenOffsetY / 2,
                                0, self.tileWidthScaleFactor, self.tileHeightScaleFactor)
        end
    end
end

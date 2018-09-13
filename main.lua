debug = true

-- GLOBAL VARIABLES
-- DO NOT RENAME

-- Screen Dimensions
screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

-- gameBoard Dimensions
gameBoardHeight = 4
gameBoardWidth = 4

-- Store game board details
-- INDEX VALUES
-- -2 = Door
-- -1 = Wall
-- 0 = Empty tile
-- 1 = Enemy
-- 5 = Player
gameBoard = {}

-- Array of all game actors
gameActors = {}

-- END GLOBAL VARIABLES

-- Tile spritesheet dimensions
local tileHeight = 16
local tileWidth = 16

-- Image storage
local playerImg = nil
local tiles = {}

-- Import actor class
local class = require 'actor'

-- Populate and empty gameBoard
for i = 1, gameBoardWidth * gameBoardHeight do
    gameBoard[i] = 0
end


-- Create game actors
local player = Actor:new('player', 3, 3, 1, 3)
local e1 = Actor:new('snake', 1, 1, 1, 1)
local e2 = Actor:new('snake', 1, 4, 1, 1)
local e3 = Actor:new('snake', 4, 4, 1, 1)
local e4 = Actor:new('snake', 4, 1, 1, 1)

-- Current user input
userInput = nil

function love.load(arg)
    love.math.random()

    -- Actors are not pixel art
    love.graphics.setDefaultFilter('linear', 'linear', 0)
    player.img = love.graphics.newImage('assets/panda.png')

    -- Tiles are pixel art
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)

    -- Choose tile sprite sheet
    if debug then
        tileSheet = love.graphics.newImage('assets/roguelikeSheet_magenta.png')
    else
        tileSheet = love.graphics.newImage('assets/roguelikeSheet_transparent.png')
    end

    tile1 = love.graphics.newQuad(6 * (tileWidth + 1) - tileWidth - 1, 0, tileHeight, tileWidth, tileSheet:getDimensions())
    tile2 = love.graphics.newQuad(7 * (tileWidth + 1) - tileWidth - 1, 0, tileHeight, tileWidth, tileSheet:getDimensions())

    actorWidth = player.img:getWidth()
    actorHeight = player.img:getHeight()
    actorWidthScaleFactor = 1 / actorWidth * screenWidth / gameBoardWidth
    actorHeightScaleFactor = 1 / actorHeight * screenHeight / gameBoardHeight

    tileWidthScaleFactor = 1 / tileWidth * screenWidth / gameBoardWidth
    tileHeightScaleFactor = 1 / tileHeight * screenHeight / gameBoardHeight
end

-- User input
function love.keypressed(key)
    -- Quit game
    if key == 'escape' then
        love.event.push('quit')
    end

    if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
        player.input = key
        for actor in ipairs(gameActors) do
            -- If player can't move exit action loop for new input
            if gameActors[actor]:takeAction() == 'playerCannotMove' then
                break
            end
        end
        for i in ipairs(gameBoard) do
            print(gameBoard[i])
        end
    end
end

function drawTileCheckerboard()
    for tile in ipairs(gameBoard) do

        -- -- Color one odd row
        if (tile % 2 == 0) and (math.floor((tile - 1) / gameBoardWidth) % 2 == 0) then
            love.graphics.draw(tileSheet, tile1, tileWidth * tileWidthScaleFactor * (tile % (gameBoardWidth) + 1),
                                tileHeight * tileHeightScaleFactor * math.ceil(tile / gameBoardWidth - 1),
                                0, tileWidthScaleFactor, tileHeightScaleFactor)

        -- Color one even row
        elseif (tile % 2 == 1) and (math.ceil(tile / gameBoardWidth) % 2 == 0) then
            love.graphics.draw(tileSheet, tile1, tileWidth * tileWidthScaleFactor * (tile % (gameBoardWidth) - 1),
                                tileHeight * tileHeightScaleFactor * math.ceil(tile / gameBoardWidth - 1),
                                0, tileWidthScaleFactor, tileHeightScaleFactor)

        -- Color two odd row
        elseif (tile % 2 == 1) and (math.floor((tile - 1) / gameBoardWidth) % 2 == 0) then
            love.graphics.draw(tileSheet, tile2, tileWidth * tileWidthScaleFactor * (tile % (gameBoardWidth) - 1),
                                tileHeight * tileHeightScaleFactor * math.ceil(tile / gameBoardWidth - 1),
                                0, tileWidthScaleFactor, tileHeightScaleFactor)
        -- color two even row
        elseif (tile % 2 == 0) and (math.ceil(tile / gameBoardWidth) % 2 == 0) then
            love.graphics.draw(tileSheet, tile2, tileWidth * tileWidthScaleFactor * (tile % (gameBoardWidth) + 1),
                                tileHeight * tileHeightScaleFactor * math.ceil(tile / gameBoardWidth - 1),
                                0, tileWidthScaleFactor, tileHeightScaleFactor)
        end
    end
end

function love.draw(dt)
    -- Draw checkerboard of tiles
    drawTileCheckerboard()

    -- Draw all game actors
    for actor in ipairs(gameActors) do
        love.graphics.draw(gameActors[actor].img,
                            (gameActors[actor].xPos - 1) * screenWidth / gameBoardWidth,
                            (gameActors[actor].yPos - 1) * screenHeight / gameBoardHeight,
                            0, actorWidthScaleFactor, actorHeightScaleFactor)
    end
end

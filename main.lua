-- GLOBAL VARIABLES
-- DO NOT RENAME

-- Screen Dimensions
screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

-- gameBoard Dimensions
gameBoardHeight = 8
gameBoardWidth = 8

fullscreen = true
heightWidthDelta = 0

-- Difference between height and width of screen
if (fullscreen == true) then
    heightWidthDelta = 1920 - 1080
end

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

local debug = true

-- Tile spritesheet dimensions
local tileHeight = 16
local tileWidth = 16

-- Image storage
local playerImg = nil
local tiles = {}

-- Import actor class
local actorClass = require 'actor'
local playerClass = require 'player'
local enemyClass = require 'enemy'

local checkerboardClass = require 'drawTileCheckerboard'
local uiClass = require 'drawUI'

-- Populate and empty gameBoard
for i = 1, gameBoardWidth * gameBoardHeight do
    gameBoard[i] = 0
end


-- Create game actors
local player = Player:new('player', 3, 3, 1, 3)
local e1 = Enemy:new('snake', 1, 1, 2, 2)
local e2 = Enemy:new('snake', 1, 8, 2, 2)
local e3 = Enemy:new('snake', 8, 8, 2, 2)
local e4 = Enemy:new('snake', 8, 1, 1, 1)

-- Current user input
userInput = nil

function love.load(arg)
    -- Load game ui images
    heartIcon = love.graphics.newImage('assets/heart_icon.png')

    -- Set random seed
    love.math.random()

    -- Make game window fullscreen
    love.window.setFullscreen(fullscreen)

    -- Actors are not pixel art
    love.graphics.setDefaultFilter('linear', 'linear', 0)
    player.img = love.graphics.newImage('assets/panda.png')

    -- Tiles are pixel art
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    local tileSheet = love.graphics.newImage('assets/roguelikeSheet_transparent.png')

    local tile1 = love.graphics.newQuad(6 * (tileWidth + 1) - tileWidth - 1, 0, tileHeight, tileWidth, tileSheet:getDimensions())
    local tile2 = love.graphics.newQuad(7 * (tileWidth + 1) - tileWidth - 1, 0, tileHeight, tileWidth, tileSheet:getDimensions())

    local actorWidth = player.img:getWidth()
    local actorHeight = player.img:getHeight()
    actorWidthScaleFactor = 1 / actorWidth * screenWidth / gameBoardWidth
    actorHeightScaleFactor = 1 / actorHeight * screenHeight / gameBoardHeight

    local tileWidthScaleFactor = 1 / tileWidth * screenWidth / gameBoardWidth
    local tileHeightScaleFactor = 1 / tileHeight * screenHeight / gameBoardHeight

    DrawTileCheckerboard = DrawTileCheckerboard:new(tileSheet, tile1, tile2, tileHeight, tileWidth, tileHeightScaleFactor, tileWidthScaleFactor)
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
            -- If player can't move, exit action loop for new input
            if gameActors[actor]:takeAction() == true then
                break
            end
        end
    end
end

function love.draw(dt)
    -- TODO Make movable camera
    -- TODO Make num grid squares displayed seperate from grid width and grid height

    -- Draw checkerboard of tiles
    DrawTileCheckerboard:drawCheckerboard()

    -- Draw all game actors
    for actor in ipairs(gameActors) do
        love.graphics.draw(gameActors[actor].img,
                            (gameActors[actor].xPos - 1) * screenWidth / gameBoardWidth + heightWidthDelta / 2,
                            (gameActors[actor].yPos - 1) * screenHeight / gameBoardHeight,
                            0, actorWidthScaleFactor, actorHeightScaleFactor)
    end

    -- Draw UI (hearts, inventory, etc)
    DrawUI:drawUI(heartIcon, player.hp)
end

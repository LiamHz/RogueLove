-- TODO_ List
-- TODO Copy Crypt of the Necrodancer AIs (movement and attack patterns) for different enemies
-- TODO Change enemy sprite based on hp
-- TODO Make camera only move when player move to a square near display edge
-- TODO Display enemy health if it is less than max
-- TODO Visual indicator of attack
-- TODO Display gameover and make entire board semi-opaque on player death
-- TODO Initialize camera to center on player
-- TODO Fix camera movement

-- GLOBAL VARIABLES
-- DO NOT RENAME

-- The gameboard is larger than what is displayed
-- gameBoard Dimensions
gameBoardHeight = 20
gameBoardWidth = 20

-- gameBoard Display Dimensions
gameBoardDisplayHeight = 10
gameBoardDisplayWidth = 10

fullscreen = true

screenOffsetX = 0
screenOffsetY = 0

-- Store game board details
-- INDEX VALUES
-- 0 = Empty tile
-- 1 = Wall
-- 2 = Door
-- 'enemy' = Enemy
-- 'player' = Player
gameBoard = {}

-- Array of all game actors
gameActors = {}

-- END GLOBAL VARIABLES

local debug = true

-- Screen Dimensions of gameBoard
local gameBoardScreenDisplayWidth = love.graphics.getWidth()
local gameBoardScreenDisplayHeight = love.graphics.getHeight()

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

-- Classes
local checkerboardClass = require 'drawTileCheckerboard'
local uiClass = require 'drawUI'
local camera = require 'camera'

-- Populate and empty gameBoard
for i = 1, gameBoardWidth * gameBoardHeight do
    gameBoard[i] = 0
end


-- Create game actors
local player = Player:new('player', 6, 5, 1, 3)
local e1 = Enemy:new('snake', 8, 2, 2, 1)
local e2 = Enemy:new('snake', 10, 4, 2, 1)
local e3 = Enemy:new('snake', 6, 4, 2, 1)
local e4 = Enemy:new('snake', 12, 8, 1, 1)

-- Initialize camera
Camera = Camera:new()

-- Current user input
userInput = nil

function love.load(arg)
    -- Set random seed
    love.math.random()

    -- Make game window fullscreen
    love.window.setFullscreen(fullscreen)

    -- Get size of screen
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()

    -- Screen dimensions are often not divisible by tileHeight/tileWidth
    -- screenOffsetX = math.floor(screenWidth / tileWidth)
    -- screenOffsetY = math.floor(screenHeight / tileHeight)
    screenOffsetX = screenWidth / tileWidth
    screenOffsetY = screenHeight / tileHeight

    -- Load game ui images
    heartIcon = love.graphics.newImage('assets/heart_icon.png')

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
    actorWidthScaleFactor = 1 / actorWidth * gameBoardScreenDisplayWidth / gameBoardDisplayWidth
    actorHeightScaleFactor = 1 / actorHeight * gameBoardScreenDisplayHeight / gameBoardDisplayHeight

    local tileWidthScaleFactor = 1 / tileWidth * gameBoardScreenDisplayWidth / gameBoardDisplayWidth
    local tileHeightScaleFactor = 1 / tileHeight * gameBoardScreenDisplayHeight / gameBoardDisplayHeight

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
    -- Camera
    Camera:set()

    -- Draw checkerboard of tiles
    DrawTileCheckerboard:drawCheckerboard()

    -- Draw all game actors
    for actor in ipairs(gameActors) do
        love.graphics.draw(gameActors[actor].img,
                            (gameActors[actor].xPos - 1) * gameBoardScreenDisplayWidth / gameBoardDisplayWidth + screenOffsetX / 2,
                            (gameActors[actor].yPos - 1) * gameBoardScreenDisplayHeight / gameBoardDisplayHeight + screenOffsetY / 2,
                            0, actorWidthScaleFactor, actorHeightScaleFactor)
    end

    -- Camera does not change position of UI elements
    Camera:unset()

    -- Hide gameBoard that is not currently displayed
    love.graphics.setColor(0, 0, 0, 10)
    -- Left side
    love.graphics.rectangle('fill', 0, 0,
                            (screenWidth - gameBoardScreenDisplayWidth) / 2, screenHeight)
    -- Right side
    love.graphics.rectangle('fill',
                            (screenWidth - gameBoardScreenDisplayWidth) / 2 + gameBoardScreenDisplayWidth, 0,
                            (screenWidth - gameBoardScreenDisplayWidth) / 2, screenHeight)

    -- Hide screen offsets

    -- TODO Use love.graphics.setColor( red, green, blue, alpha ) and love.graphics.rectangle("fill", x, y, width, height ) to make edge of game board semi-opaque

    -- Make edges of board semi opaque

    -- Make edges of board semi opaque

    -- Reset LOVE colors to default
    love.graphics.setColor(255, 255, 255, 255)

    -- Draw UI (hearts, inventory, etc)
    DrawUI:drawUI(heartIcon, player.hp)
end

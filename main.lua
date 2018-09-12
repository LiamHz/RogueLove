debug = true

-- GLOBAL VARIABLES
-- DO NOT RENAME

-- Screen Dimensions
screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

-- gameBoard Dimensions
gameBoardHeight = 10
gameBoardWidth = 10

-- Store game board details
gameBoard = {}

-- Array of all game actors
gameActors = {}

-- END GLOBAL VARIABLES


-- Image storage
local playerImg = nil

-- Import actor class
local class = require 'actor'

-- Populate and empty gameBoard
for i = 1, gameBoardWidth * gameBoardHeight do
    gameBoard[i] = 0
end


-- Create game actors
local player = Actor:new('player', 3, 3, 1, 3)
local e1 = Actor:new('snake', 1, 1, 1, 1)
local e2 = Actor:new('snake', 1, 10, 2, 1)
local e3 = Actor:new('snake', 10, 10, 3, 1)
local e4 = Actor:new('snake', 10, 1, 4, 1)

-- Current user input
userInput = nil

function love.load(arg)
    player.img = love.graphics.newImage('assets/panda.png')

    imgWidth = player.img:getWidth()
    imgHeight = player.img:getHeight()
    imgWidthScaleFactor = 1 / imgWidth * screenWidth / gameBoardWidth
    imgHeightScaleFactor = 1 / imgHeight * screenHeight / gameBoardHeight
end

function love.keypressed(key)
    -- Quit game
    if key == 'escape' then
        love.event.push('quit')
    end

    if key == 'up' or key == 'down' or key == 'left' or key == 'right' then
        player.input = key
        for actor in ipairs(gameActors) do
            gameActors[actor]:takeAction()
        end
    end
end

function love.draw(dt)
    -- TODO make a checkerboard pattern of tiles

    for actor in ipairs(gameActors) do
        love.graphics.draw(gameActors[actor].img,
                            (gameActors[actor].xPos - 1) * screenWidth / gameBoardWidth,
                            (gameActors[actor].yPos - 1) * screenHeight / gameBoardHeight,
                            0, imgWidthScaleFactor, imgHeightScaleFactor)
    end
end

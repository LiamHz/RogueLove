-- Import OOP library middleclass
local class = require 'lib.middleclass'

-- Inheritance
local parent = require 'actors.actor'

Player = class('Player', Actor)

function Player:initialize(xPos, yPos)
    Actor.initialize(self, xPos, yPos)

    -- Used to keep player centered with camera
    self.distanceFromCenterHorizontal = 0
    self.distanceFromCenterVertical = 0

    self.actorType = 'player'
    self.hp = 3
    self.energyThreshold = 1
    self.damage = 1

    -- Mark actor's gameboard square as occupied
    gameBoard[self.tileIndexPos] = 'player'
end

function Player:takeAction()
    self.energy = self.energy + 1
    -- Turn speed system
    if self.energy >= self.energyThreshold then

        pastXPos, pastYPos = self.xPos, self.yPos

        actorCannotMove = self:getDecision()

        -- Ask for new user input if player couldn't move
        -- i.e. walked into a wall
        if actorCannotMove == true then
            return actorCannotMove
        end

        -- Mark previous square as empty
        gameBoard[pastXPos + (pastYPos - 1) * gameBoardWidth] = 0

        -- Update gameBoard with position of game actor
        gameBoard[self.xPos + (self.yPos - 1) * gameBoardWidth] = 'player'

        -- Update actor's tileIndexPosition
        self.tileIndexPos = self.xPos + (self.yPos - 1) * gameBoardWidth

        -- Subtract actor energy
        self.energy = self.energy - self.energyThreshold
    end

    return false
end

-- Determine player action based on input
function Player:getDecision()
    -- Tile index is a single number from 0 to GB Height * GB Width
    local tileIndex = self.xPos + (self.yPos - 1) * gameBoardWidth

    if (self.input == 'up') and (gameBoard[tileIndex - gameBoardWidth] == 'enemy') then
        targetPos = tileIndex - gameBoardWidth
        AttackAction:attack(targetPos, self.damage)
    elseif (self.input == 'down') and (gameBoard[tileIndex + gameBoardWidth] == 'enemy') then
        targetPos = tileIndex + gameBoardWidth
        AttackAction:attack(targetPos, self.damage)
    elseif (self.input == 'left') and (gameBoard[tileIndex - 1] == 'enemy') then
        targetPos = tileIndex - 1
        AttackAction:attack(targetPos, self.damage)
    elseif (self.input == 'right') and (gameBoard[tileIndex + 1] == 'enemy') then
        targetPos = tileIndex + 1
        AttackAction:attack(targetPos, self.damage)
    else
        -- Walk the direction of input
        self.xPos, self.yPos, actorCannotMove = WalkAction:walk(self.xPos, self.yPos, self.input)

        -- Move camera to keep player centered
        if actorCannotMove == false then
            if self.input == 'up' then
                self.distanceFromCenterVertical = self.distanceFromCenterVertical + 1
                if self.distanceFromCenterVertical > 3 then
                    Camera:move(0, -tileHeight * tileHeightScaleFactor)
                    self.distanceFromCenterVertical = self.distanceFromCenterVertical - 1
                end
            elseif self.input == 'down' then
                self.distanceFromCenterVertical = self.distanceFromCenterVertical - 1
                if self.distanceFromCenterVertical < -3 then
                    Camera:move(0, tileHeight * tileHeightScaleFactor)
                    self.distanceFromCenterVertical = self.distanceFromCenterVertical + 1
                end
            elseif self.input == 'left' then
                self.distanceFromCenterHorizontal = self.distanceFromCenterHorizontal - 1
                if self.distanceFromCenterHorizontal < -3 then
                    Camera:move(-tileWidth * tileWidthScaleFactor, 0)
                    self.distanceFromCenterHorizontal = self.distanceFromCenterHorizontal + 1
                end
            elseif self.input == 'right' then
                self.distanceFromCenterHorizontal = self.distanceFromCenterHorizontal + 1
                if self.distanceFromCenterHorizontal > 3 then
                    Camera:move(tileWidth * tileWidthScaleFactor, 0)
                    self.distanceFromCenterHorizontal = self.distanceFromCenterHorizontal - 1
                end
            end
        end
    end

    return actorCannotMove
end

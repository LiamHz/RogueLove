-- Import OOP library middleclass
local class = require 'lib.middleclass'

AttackAction = class('AttackAction')

function AttackAction:initialize()
    self.name = 'AttackAction'
end

function AttackAction:attack(targetPos, damage)

    for actor in ipairs(gameActors) do

        -- Find target of attack and deal damage
        if gameActors[actor].tileIndexPos == targetPos then
            gameActors[actor].hp = gameActors[actor].hp - damage
            -- print('Name: ' .. gameActors[actor].actorType .. gameActors[actor].id .. ', HP: ' .. gameActors[actor].hp)

            -- If that actor died, remove them from table of game actors
            -- And mark that square as empty
            if gameActors[actor].hp <= 0 then
                table.remove(gameActors, actor)
                gameBoard[targetPos] = 0
            end
        end
    end
end

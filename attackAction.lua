-- Import OOP library middleclass
local class = require 'middleclass'

AttackAction = class('AttackAction')

function AttackAction:initialize()
    self.name = 'AttackAction'
end

function AttackAction:attack(input)

    -- TODO Subtract health of actor in target square
    -- TODO Visual indicator of health subtraction
    if input == 'up' then
        print('Attack Up!')
    elseif input == 'down' then
        print('Attack Down!')
    elseif input == 'left' then
        print('Attack Left!')
    elseif input == 'right' then
        print('Attack Right!')
    end
end

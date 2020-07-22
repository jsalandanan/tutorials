Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/hump/timer'
EnhancedTimer = require 'libraries/EnhancedTimer/EnhancedTimer'
M = require 'libraries/Moses/moses'

require('utils')

require('rooms/Room')
require('rooms/Stage')

require('objects/GameObject')

require('areas/Area')

function love.load()
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    love.math.setRandomSeed(love.timer.getTime())

    timer = Timer()

    stage = Stage()
    area = Area(stage)

    circlesCreate(area)
end

function circlesCreate(area)
    if cleanup then timer:cancel(cleanup) end

    for i=1,10 do
        timer:after(0.25*i, function()
            area:addGameObject('Circle', love.math.random(0, 500), love.math.random(0, 500), {radius=love.math.random(15, 35)})
        end)
    end

    timer:after(2.5, function()
        cleanup = timer:every(random(0.5, 1), function()
            if #area.game_objects ~= 0 then
                area.game_objects[love.math.random(1, #area.game_objects)].dead = true
            end
            if #area.game_objects == 0 then
                circlesCreate(area)
            end
        end)
    end)
end

function love.update(dt)
    timer:update(dt)
    area:update(dt)
end

function love.draw()
    area:draw()
end

function gotoRoom(room_type, ...)
    print(_G[room_type])
    current_room = _G[room_type](...)
end

function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.isFile(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end

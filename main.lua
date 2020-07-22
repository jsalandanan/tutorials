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

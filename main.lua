Object = require 'libraries/classic/classic'
Timer = require 'libraries/enhanced_timer/EnhancedTimer'
Input = require 'libraries/boipushy/Input'
fn = require 'libraries/moses/moses'

require 'GameObject'
require 'utils'

function love.load()
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)
    local room_files = {}
    recursiveEnumerate('rooms', room_files)
    requireFiles(room_files)

    love.graphics.setDefaultFilter('nearest')
    love.graphics.setLineStyle('rough')

    timer = Timer()
    input = Input()

    stage = Stage()

    resize(3)
end

function love.update(dt)
    timer:update(dt)
    stage:update(dt)
    if current_room then current_room:update(dt) end
end

function love.draw()
    stage:draw()
    if current_room then current_room:draw() end
end

function resize(s)
    love.window.setMode(s*gw, s*gh)
    sx, sy = s, s
end

-- Room --
function gotoRoom(room_type, ...)
    if current_room and current_room.destroy then current_room:destroy() end
    current_room = _G[room_type](...)
end

-- Load --
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

Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'

function love.load()
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    input = Input()
    input:bind('kp+', 'sum')


    sum = 0
end

function love.update(dt)
    if input:down('sum', 0.25) then
      sum = sum + 1
    end
end

function love.draw()
  love.graphics.print(sum)
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

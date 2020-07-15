Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/hump/timer'
EnhancedTimer = require 'libraries/EnhancedTimer/EnhancedTimer'

function love.load()
    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    input = Input()
    input:bind('d', 'hp_decrement')
    timer = Timer()
    base_hp_bar = {x = 400, y = 300, w = 200, h = 50, starting_w = 200, starting_h = 50}
    tracking_hp_bar = {x = 400, y = 300, w = 200, h = 50, starting_w = 200, starting_h = 50}
    -- timer:tween(1, base_hp_bar, {x = 400, y = 300, w = 160, h = 50}, 'in-out-cubic')

    -- function() timer:tween(1, rect_2, {x = 400, y = 300, w = 200, h = 0}, 'in-out-cubic',
    --     function()
    --         timer:tween(2, base_hp_bar, {x = 400, y = 300, w = 50, h = 200}, 'in-out-cubic')
    --         timer:tween(2, rect_2, {x = 400, y = 300, w = 200, h = 50},'in-out-cubic')
    --     end)
    -- end)
end

function love.update(dt)
  timer:update(dt)
  if input:pressed('hp_decrement')
    then bars('event_tag', 1, base_hp_bar, 'tracking_event_tag', 1.5, tracking_hp_bar, 'in-out-cubic', 4)
  end
end

function bars(hp_bar_tag, hp_bar_delay, hp_bar, tracking_event_tag, traacking_hp_bar_delay, tracking_hp_bar, mode, rate)
    timer:tween(
        -- hp_bar_tag,
        hp_bar_delay,
        hp_bar,
        {
            x = hp_bar.x,
            y = hp_bar.y,
            w = math.max(hp_bar.w - hp_bar.starting_w / rate, 0),
            h = hp_bar.h,
            starting_w = hp_bar.starting_w,
            starting_h = hp_bar.starting_h
        },
        mode
    )
    timer:tween(
        -- tracking_event_tag,
        traacking_hp_bar_delay,
        tracking_hp_bar,
        {
            x = tracking_hp_bar.x,
            y = tracking_hp_bar.y,
            w = math.max(tracking_hp_bar.w - tracking_hp_bar.starting_w / rate, 0),
            h = tracking_hp_bar.h,
            starting_w = tracking_hp_bar.starting_w,
            starting_h = tracking_hp_bar.starting_h
        },
        mode
    )
end

-- set the tracking bar x and y to the 

function love.draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', tracking_hp_bar.x - tracking_hp_bar.starting_w/2, tracking_hp_bar.y - tracking_hp_bar.starting_h/2, tracking_hp_bar.w, tracking_hp_bar.h)
    love.graphics.setColor(255, 100, 100)
    love.graphics.rectangle('fill', base_hp_bar.x - base_hp_bar.starting_w/2, base_hp_bar.y - base_hp_bar.starting_h/2, base_hp_bar.w, base_hp_bar.h)

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

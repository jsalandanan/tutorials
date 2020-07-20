function UUID()
    local fn = function(x)
        local r = math.random(16) - 1
        r = (x == "x") and (r + 1) or (r % 4) + 9
        return ("0123456789abcdef"):sub(r, r)
    end
    return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end

function random(min, max)
    if not max then
        return love.math.random()*min
    else
        if min > max then min, max = max, min end
        return love.math.random()*(max - min) + min
    end
end

function printAll(...)
  local arg = {...}
  for i=1, #arg do
    print(arg[i])
  end
end

function printText(...)
  local arg = {...}
  local strToPrint = ''
  for i=1, #arg do
    strToPrint = strToPrint .. arg[i]
  end
  print(strToPrint)
end
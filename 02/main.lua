LookupTable = {}
LookupTable['red'] = 12
LookupTable['green'] = 13
LookupTable['blue'] = 14

function GetFileLines()
    local lines = {}
    for line in io.lines('input.txt') do
        lines[#lines + 1] = line 
    end
    return lines
end

function GetSubGames(game)
    local subGames = {}
    local subGame = ''
    local start = game:find(':')
    local current
    for i = start + 1, #game do
        current = game:sub(i, i)
        if current ~= ';' then
            subGame = subGame..current
        else
            subGames[#subGames+1] = subGame
            subGame = ''
        end
        -- print(subGame)
    end
    subGames[#subGames+1] = subGame
    return subGames
end

function GetCubes(subGame)
    local cubes = {}
    local current = ''
    local cube = ''
    for i = 1, #subGame do
        current = subGame:sub(i, i)
        if current ~= ',' then
            cube = cube..current
        else
            cubes[#cubes+1] = cube:sub(2, #cube)
            cube = ''
        end
        -- print(cube)
    end
    cubes[#cubes+1] = cube:sub(2, #cube)
    return cubes
end

function EvaluateGame(game)
    local id = ''
    local i = 6
    while game:sub(i, i) ~= ':'  do
        id = id..game:sub(i, i) 
        i = i + 1
    end  

    local number = ''
    local color = ''
    local subGames = GetSubGames(game)

    for j, subGame in ipairs(subGames) do
        local cubes = GetCubes(subGame)
        for k, cube in ipairs(cubes) do
            for l = 1, #cube do 
                if tonumber(cube:sub(l, l)) ~= nil then
                    number = number..cube:sub(l, l)
                end
            end
            for l = cube:find(' ') + 1, #cube do
                color = color..cube:sub(l, l)
            end
            -- print(number)
            -- print(color)
            if tonumber(number) > LookupTable[color] then
                return nil
            end
            number = ''
            color = ''
        end
    end

    return id
end

Lines = GetFileLines()

Sum = 0
for i = 1, #Lines do
    local gameid = EvaluateGame(Lines[i])
    if gameid ~= nil then
        Sum = Sum + gameid
    end
end

print(Sum)
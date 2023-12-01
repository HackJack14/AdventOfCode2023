DigitsAsStrings = {'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'}

function GetFileLines()
    local lines = {}
    for line in io.lines('input.txt') do
        lines[#lines + 1] = line 
    end
    return lines
end

function BetterEvaluateString(line)
    local numbers = {}
    --Look for literal numbers
    for i = 1, #line do
        local current = line:sub(i, i)
        if tonumber(current) ~= nil then
            numbers[i] = current
        end
    end

    --Look for digits as strings
    for i = 1, #line do
        for j = 1, #DigitsAsStrings do
            local current = line:find(DigitsAsStrings[j], i)
            if current ~= nil then
                numbers[current] = j
            end
        end
    end

    --Search for the first and last number
    local first
    local second
    for i = 1, 100 do
        if numbers[i] ~= nil then
            if first == nil then
                first = numbers[i]
            else
                second = numbers[i]
            end
        end
    end
    if second == nil then
        second = first
    end
    return first..second
end

function EvaluateString(line)
    local first
    local second
    for i = 1, #line do
        local current = line:sub(i, i)
        if tonumber(current) ~= nil then
            if first == nil then
                first = current
            else
                second = current
            end
        end
    end
    if second == nil then
        second = first
    end
    return first..second
end

Lines = GetFileLines()
Sum1 = 0
Sum2 = 0
for i = 1, #Lines do
    Sum1 = Sum1 + EvaluateString(Lines[i])
    Sum2 = Sum2 + BetterEvaluateString(Lines[i])
end

print('Only literal numbers')
print(Sum1)
print('With digits as strings')
print(Sum2)
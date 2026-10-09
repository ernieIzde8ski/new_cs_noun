local export = {}

local titleObj = mw.title.getCurrentTitle()
local pageName = mw.text.trim(titleObj.text)

local find = mw.ustring.find
local length = mw.ustring.len
local match, gmatch = mw.ustring.match, mw.ustring.gmatch
local sub, gsub = mw.ustring.sub, mw.ustring.gsub

local function arrayContains<T>(array: {T}, value: T): boolean
    for _, member in ipairs(array) do
        if member == value then
            return true
        end
    end
    return false
end


function export.new(frame: Frame): string
	local args = frame:getParent().args

    local includePronunciation = args["pronunciation"] ~= "0"

    local result = "==Czech=="
    if includePronunciation then
        result = result .. "\n\n" .. [[===Pronunciation===
* {{cs-IPA}]]
    end

    return result
end

return export

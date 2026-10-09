local export = {}

-- local titleObj = mw.title.getCurrentTitle()
-- local pageName = mw.text.trim(titleObj.text)


-- local function arrayContains<T>(array: {T}, value: T): boolean
--     for _, member in ipairs(array) do
--         if member == value then
--             return true
--         end
--     end
--     return false
-- end


function export.new(frame: Frame): string
    local args = frame:getParent().args

	assert(#args as {string} >= 2, "should have at least 2 params (received " .. #args as
    {string} .. ")")
    local gender = args[1]
    local definition = args[2]
    local includePronunciation = args["pronunciation"] ~= "0"

    local result = "==Czech=="

    if includePronunciation then
        result = result .. "\n\n" .. [[===Pronunciation===
* {{cs-IPA}}]]
    end

    result = result .. "\n\n"
    result = result .. [[===Noun===
{{cs-noun|]] .. gender .. [[}}

* ]] .. definition


    return result
end

return export

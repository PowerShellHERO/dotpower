
local function is_empty(var)
    return var == nil or var == ''
end

local function get_sub()
    mp.osd_message("Yamp")
    local sub_text = mp.get_property("sub-text")
    if not is_empty(sub_text) then
        set_clipboard(sub_text)
        mp.osd_message(sub_text)
    end
    return nil
end

-- mp.observe_property("sub-text", "string", copy_to_clipboard)
-- mp.observe_property("sub-text", "string", get_sub)
--

mp.add_key_binding("Shift+y", "get_sub", get_sub)


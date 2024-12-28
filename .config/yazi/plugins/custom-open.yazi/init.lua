--- @sync entry

local function setup(self, opts) end

local function entry(self)
    local h = cx.active.current.hovered
    local original_url = h.link_to
    if h and original_url then
        local jump_url = original_url
        if not h.cha.is_dir then
            jump_url = original_url:parent()
        end
        ya.manager_emit('cd', { jump_url })
    else
        ya.manager_emit('open', {})
    end
end

return { entry = entry, setup = setup }

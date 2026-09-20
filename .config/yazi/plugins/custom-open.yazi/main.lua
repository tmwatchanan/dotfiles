--- @sync entry

local function setup(self, opts) end

local function entry(self)
    local h = cx.active.current.hovered
    if h and h.link_to then
        -- join resolves relative link targets against the link's own directory
        local jump_path = h.url.parent.path:join(h.link_to)
        if not h.cha.is_dir then
            jump_path = jump_path.parent
        end
        ya.emit('cd', { Url(tostring(jump_path)) })
    else
        ya.emit('open', {})
    end
end

return { entry = entry, setup = setup }

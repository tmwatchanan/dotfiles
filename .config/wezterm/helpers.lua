local function copyAll(win, pane) -- copy all text in a pane (except for bottom prompt in Xonsh)
    local prompt_bottom_offset = 0
    local proc = pane:get_foreground_process_info()
    local name, binpath, arg = proc.name, proc.executable, proc.argv
    local isXonsh = sh.isXonsh(arg)
    if isXonsh then
        if os.getenv("BOTTOM_TOOLBAR") then
            prompt_bottom_offset = 2 -- exclude the main + bottom prompts
        else
            prompt_bottom_offset = 1 -- exclude the main          prompt
        end
    end

    local dims = pane:get_dimensions()
    local txt  = pane:get_text_from_region(0
    , dims.scrollback_top, 0
    , dims.scrollback_top + dims.scrollback_rows - prompt_bottom_offset)
    win:copy_to_clipboard(txt:match('^%s*(.-)%s*$')) -- trim leading and trailing whitespace
end

return {
    copyAll = copyAll,
}

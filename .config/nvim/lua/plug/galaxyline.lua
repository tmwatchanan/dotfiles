local gl = require('galaxyline')
local condition = require('galaxyline.condition')
local fileinfo = require('galaxyline.provider_fileinfo')
local lspclient = require('galaxyline.provider_lsp')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

-- local colors = require('galaxyline.theme').default
local colors = {
    none = "NONE",
    bg_dark = "#1f2335",
    bg = "#414868", -- #24283b
    bg_highlight = "#292e42",
    terminal_black = "#414868",
    fg = "#c0caf5",
    fg_dark = "#a9b1d6",
    fg_gutter = "#3b4261",
    dark3 = "#545c7e",
    comment = "#565f89",
    dark5 = "#737aa2",
    blue0 = "#3d59a1",
    blue = "#7aa2f7",
    cyan = "#7dcfff",
    blue1 = "#2ac3de",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#B4F9F8",
    blue7 = "#394b70",
    magenta = "#bb9af7",
    purple = "#9d7cd8",
    orange = "#ff9e64",
    yellow = "#e0af68",
    green = "#9ece6a",
    green1 = "#73daca",
    green2 = "#41a6b5",
    teal = "#1abc9c",
    red = "#f7768e",
    red1 = "#db4b4b",
    git = { change = "#6183bb", add = "#449dab", delete = "#914c54", conflict = "#bb7a61" },
    gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
}

local icons = {
    sep = {
        left = "",
        right = "",
        space = " "
    },
}

local mode_config = setmetatable({
    ['n']  = {'Normal', 'N', colors.red},
    ['no'] = {'N·Pending', 'N·P', colors.red},
    ['v']  = {'Visual', 'V' , colors.blue},
    ['V']  = {'V·Line', 'V·L' , colors.blue},
    [""] = {'V·Block', 'V·B', colors.blue},
    ['s']  = {'Select', 'S', colors.orange},
    ['S']  = {'S·Line', 'S·L', colors.orange},
    [""] = {'S·Block', 'S·B', colors.orange},
    ['i']  = {'Insert', 'I', colors.green},
    ['ic'] = {'Insert', 'I', colors.yellow},
    ['R']  = {'Replace', 'R', colors.magenta},
    ['Rv'] = {'V·Replace', 'V·R', colors.magenta},
    ['c']  = {'Command', 'C', colors.magenta},
    ['cv'] = {'Vim·Ex ', 'V·E', colors.red},
    ['ce'] = {'Ex ', 'E', colors.red},
    ['r']  = {'Prompt ', 'P', colors.cyan},
    ['rm'] = {'More ', 'M', colors.cyan},
    ['r?'] = {'Confirm ', 'C', colors.cyan},
    ['!']  = {'Shell ', 'S', colors.red},
    ['t']  = {'Terminal ', 'T', colors.red},
}, {
    __index = function() -- nil
        -- return {'Unknown', 'U', colors.blue}
        return {'V·Block', 'V·B', colors.blue}
    end
})

local sectionCount = {
    left = 0,
    mid = 0,
    right = 0,
    short_line_left = 0,
    short_line_right = 0
}

local nextSectionNum = function(sectionKind)
    local num = sectionCount[sectionKind] + 1
    sectionCount[sectionKind] = num
    return num
end

local addSection = function(sectionKind, section)
    local num = nextSectionNum(sectionKind)
    local id = sectionKind .. "_" .. num .. "_" .. section.name
    -- note: this is needed since id's get mapped to highlights name `Galaxy<Id>`
    if (section.useNameAsId == true) then
        id = section.name
    end
    gls[sectionKind][num] = {
        [id] = section
    }
end

local addSections = function(sectionKind, sections)
    for _, section in pairs(sections) do
        addSection(sectionKind, section)
    end
end

local string_provider = function(str)
    return function()
        return str
    end
end

local createSeparatorSection = function(bg, fg, sep)
    bg = bg or colors.bg
    fg = fg or bg
    sep = sep or ' '
    return {
        name = "whitespace",
        provider = string_provider(sep),
        highlight = {fg, bg}
    }
end

addSections("left", {
    createSeparatorSection(colors.base04),
    {
        name = "RainbowRed",
        provider = function() return '▊ ' end,
        highlight = {colors.blue,colors.bg},
    },
    createSeparatorSection(colors.bg),
    {
        name = "ViMode",
    },
    createSeparatorSection(colors.bg),
    {
        name = "FileSize",
        provider = 'FileSize',
        condition = condition.buffer_not_empty,
        highlight = {colors.dark5,colors.bg}
    },
    -- {
    --     name = "FileIcon",
    --     provider = 'FileIcon',
    --     condition = condition.buffer_not_empty,
    --     highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
    -- },
    {
        name = "FileName",
        provider = 'FileName',
        condition = condition.buffer_not_empty,
        highlight = {colors.green1,colors.bg,'bold'}
    },
    {
        name = "LineInfo",
        provider = 'LineColumn',
        highlight = {colors.fg,colors.bg},
    },
    {
        name = "PerCent",
        provider = 'LinePercent',
        highlight = {colors.fg_dark,colors.bg,'bold'},
    },
    {
        name = "ScrollBar",
        provider = 'ScrollBar',
        highlight = {colors.cyan,colors.dark3},
    },
    createSeparatorSection(colors.bg),
    {
        name = "DiagnosticError",
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red,colors.bg}
    },
    {
        name = "DiagnosticWarn",
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.yellow,colors.bg},
    },
    {
        name = "DiagnosticHint",
        provider = 'DiagnosticHint',
        icon = '  ',
        highlight = {colors.cyan,colors.bg},
    },
    {
        name = "DiagnosticInfo",
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = {colors.blue,colors.bg},
    },
    createSeparatorSection(colors.bg),
    {
        name = "leftCap",
        provider = string_provider(icons.sep.right),
        condition = condition.buffer_not_empty,
        highlight = {colors.bg, colors.none},
    },
})


gls.left[4] = {
    ViMode = {
        provider = function()
            local mode = mode_config[vim.fn.mode()]
            local name = mode[1]
            local color = mode[3]
            vim.api.nvim_command('hi GalaxyViMode guifg='..color)
            return fileinfo.get_file_icon()
            -- return string.format('%s %s ', fileinfo.get_file_icon(), name)
        end,
        highlight = {colors.fg,colors.bg,'bold'},
    }
}

gls.mid[1] = {
    ShowLspClient = {
        provider = function()
            local lsp_text = string.format(' LSP: %s ', lspclient.get_lsp_client())
            return lsp_text
            -- return string.format('%s %s %s', icons.sep.left, lsp_text, icons.sep.right)
        end,
        condition = function ()
            local tbl = {['dashboard'] = true,['']=true}
            if tbl[vim.bo.filetype] then
                return false
            end
            return condition.hide_in_width()
        end,
        highlight = {colors.blue0, colors.none},
    }
}

addSections("right", {
    {
        name = "rightCap",
        provider = string_provider(icons.sep.left),
        condition = condition.buffer_not_empty,
        highlight = {colors.bg, colors.none},
    },
    createSeparatorSection(colors.bg),
    {
        name = "FileEncode",
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = icons.sep.space,
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.fg,colors.bg,'bold'}
    },
    -- {
    --     name = "FileFormat",
    --     provider = 'FileFormat',
    --     condition = condition.hide_in_width,
    --     separator = icons.sep.space,
    --     separator_highlight = {'NONE',colors.bg},
    --     highlight = {colors.blue,colors.bg,'bold'}
    -- },
    {
        name = "GitIcon",
        provider = function() return '  ' end,
        condition = function()
            return condition.check_git_workspace() and condition.hide_in_width()
        end,
        separator = icons.sep.space,
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.magenta,colors.bg,'bold'},
    },
    {
        name = "GitBranch",
        provider = 'GitBranch',
        condition = function()
            return condition.check_git_workspace() and condition.hide_in_width()
        end,
        highlight = {colors.magenta,colors.bg,'bold'},
    },
    -- icon = ' ',
    -- icon = ' ',
    -- icon = ' ',
    {
        name = "DiffAdd",
        provider = 'DiffAdd',
        condition = function()
            return condition.check_git_workspace() and condition.hide_in_width()
        end,
        icon = '  ',
        separator = icons.sep.space,
        separator_highlight = {'NONE',colors.bg},
        highlight = {colors.green,colors.bg},
    },
    {
        name = "DiffModified",
        provider = 'DiffModified',
        condition = function()
            return condition.check_git_workspace() and condition.hide_in_width()
        end,
        icon = '  ', -- 柳
        highlight = {colors.orange,colors.bg},
    },
    {
        name = "DiffRemove",
        provider = 'DiffRemove',
        condition = function()
            return condition.check_git_workspace() and condition.hide_in_width()
        end,
        icon = '  ',
        highlight = {colors.red,colors.bg},
    },
    {
        name = "RainbowBlue",
        provider = function() return ' ▊' end,
        highlight = {colors.blue,colors.bg}
    },
    createSeparatorSection(colors.base04),
})


gls.short_line_left[1] = {
    BufferType = {
        provider = function()
            return string.format('%s %s', fileinfo.get_file_icon(), fileinfo.get_current_file_name())
        end,
        highlight = {colors.green2,colors.fg_gutter,'bold'},

        separator = icons.sep.space,
        separator_highlight = {'NONE',colors.fg_gutter},
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider= 'BufferIcon',
        highlight = {colors.fg,colors.fg_gutter}
    }
}


local json = require('csc.json')

local M = {}

local find = function(tabl, str)
    for index,value in ipairs(tabl) do
        if value == str then
            return index
        end
    end
    return nil
end

local get_table_ind = function(table_obj)
    local current_colorscheme = vim.g.colors_name
    local index = find(table_obj, current_colorscheme) or 0

    return {colorscheme=current_colorscheme, index=index, schemes=table_obj}
end

local table_obj = json.decode('["gruvbox", "base16-tomorrow-night"]')

function M.next()
    local obj = get_table_ind(table_obj)
    local curr = obj.index
    local tabl = obj.schemes

    local n = table.getn(tabl)
    local next_ind = (curr%n) + 1
    vim.cmd('silent colorscheme ' .. tabl[next_ind])
    print("current colorscheme is " .. tabl[next_ind])
end

function M.prev()
    local obj = get_table_ind(table_obj)
    local tabl = obj.colorscheme
    local curr = obj.index

    local n = table.getn(tabl)
    local prev_ind = ((curr - 1 + n)%n) + 1
    vim.cmd('silent colorscheme ' .. tabl[prev_ind])
end

return M


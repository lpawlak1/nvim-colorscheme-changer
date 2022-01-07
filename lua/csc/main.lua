local M = {}

local find = function(tabl, str)
    for index,value in ipairs(tabl) do
        if value == str then
            return index
        end
    end
    return nil
end

local prepare_data = function()
    local config = require('csc.config')

    local table_obj = config.schemes

    local curr_index = find(table_obj, vim.g.colors_name) or 0
    local n = table.getn(table_obj)

    return {curr=curr_index, n=n, tabl=table_obj}
end

local change_schema = function (name)
    vim.cmd('silent colorscheme ' .. name)
    print("current colorscheme is " .. name)
end

function M.next()
    local data = prepare_data()
    local next_ind = (data.curr%data.n) + 1
    change_schema(data.tabl[next_ind])
end

function M.prev()
    local data = prepare_data()
    local prev_ind = ((data.curr - 2 + data.n)%data.n) + 1
    change_schema(data.tabl[prev_ind])
end

return M


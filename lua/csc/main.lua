local M = {}


local change_schema = function (name)
    vim.cmd('silent colorscheme ' .. name)
    print("current colorscheme is " .. name)
end

local find = function(tabl, str)
    for index,value in ipairs(tabl) do
        if value == str then
            return index
        end
    end
    return nil
end

local prepare_data = function()
    local config = Opts or nil
    if config == nil or config.schemes == nil then
        return nil
    end

    local table_obj = config.schemes

    local curr_index = find(table_obj, vim.g.colors_name) or 0
    local n = table.getn(table_obj)

    return {curr=curr_index, n=n, tabl=table_obj}
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

-- our picker function: colors
function M.telescope()
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"

    Opts.telescope_opts = Opts.telescope_opts or {}

    pickers.new(Opts.telescope_opts, {
            prompt_title = "Pick desired color scheme",
            finder = finders.new_table {
                results = prepare_data().tabl,
            },
            sorter = conf.generic_sorter(Opts.telescope_opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    change_schema(selection[1])
                end)
                return true
            end,
        }):find()
end

return M


local _config = {}

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

---@class GlobalOptions
---@field schemes string[]
---@field telescope_opts any
Opts = {}

local function map_cmds()
  vim.cmd('command! CscNext lua require("csc.main").next()')
  vim.cmd('command! CscPrev lua require("csc.main").prev()')
  vim.cmd('command! CscTelescope lua require("csc.main").telescope(nil)')
end

local function ensure_all_fields_map(value)
  value.mode = value.mode or 'n'
  value.map = value.map or nil
  value.command = value.command or value.cmd or nil
end

---@class MapsItem
---@field mode string
---@field map string
---@field telescope_opts string
local mapsClass = {}


---@class Maps
---@field next MapsItem
---@field prev MapsItem
---@field telescope MapsItem
local mapsClass2 = {}

---@class Options
---@field schemes string[]
---@field maps Maps
local optsClass = {}

---@param opts Options
---@return any
function _config.config(opts)
  opts = opts or nil
  if opts == nil then
    return nil
  end

  Opts.schemes = opts.schemes -- save state i guess
  map_cmds() -- map functions in memory

  if opts.maps ~= nil then
    if opts.maps.next ~= nil then
      local value = opts.maps.next
      ensure_all_fields_map(value)
      if value.map ~= nil then
        map(value.mode, value.map, '<cmd>CscNext<CR>')
      end
    end

    if opts.maps.prev ~= nil then
      local value = opts.maps.prev
      ensure_all_fields_map(value)
      if value.map ~= nil then
        map(value.mode, value.map, '<cmd>CscPrev<CR>')
      end
    end

    if opts.maps.telescope ~= nil then
      local value = opts.maps.telescope
      ensure_all_fields_map(value)
      value.telescope_opts = value.telescope_opts or nil
      Opts.telescope_opts = value.telescope_opts
      if value.map ~= nil then
        map(value.mode, value.map, '<cmd>CscTelescope<CR>')
      end
    end
  end

end --function

return _config

local _config = {}

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function _config.map_keys()
  map('n', '<leader>cl', "<cmd>lua require('csc.main').next()<CR>")
  map('n', '<leader>ch', "<cmd>lua require('csc.main').prev()<CR>")
end


_config.schemes={"gruvbox", "base16-tomorrow-night"}

return _config

# Colorscheme changer for nvim

Ever wondered could you change your color scheme even faster
and cycle through you best picks as one is not enough

**And here comes a solution**

<!-- Neovim ColorScheme Changer: nvim-csc -->

Just put your desired schemes in config
Set up your keybindings or follow defaults
And You are done

## Prerequisites

- nvim 0.5+
- telescope.nvim (optionally)

## Installation

Use your favorite plugin manager to install this plugin. [tpope/vim-pathogen](https://github.com/tpope/vim-pathogen), [VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim), [junegunn/vim-plug](https://github.com/junegunn/vim-plug), and [Shougo/dein.vim](https://github.com/Shougo/dein.vim) are some of the more popular ones.


Personally I use vim-plug and instructions are shown below.
<details>
<summary>Vim-Plug</summary>

1. Install Vim-Plug, according to its instructions.
2. Add the following text to your `init.vim`.
```vim
call plug#begin()
  Plug 'lpawlak1/nvim-colorscheme-changer'
call plug#end()
lua << EOF
require('csc.config').config({
    schemes = {'gruvbox', 'default', 'base16-tomorrow-night'}
})
EOF
```
3. Restart nvim/`:source $MYVIMRC`, and run the `:PlugInstall` to install your plugins.

</details>

## Setup

Basic config can look like this
```lua
require('csc.config').config({
    schemes = {'gruvbox', 'default', 'base16-tomorrow-night'},
    maps = {
        next={
          map='<leader>cl'
        },
        prev={
          map='<leader>ch'
        },
        telescope={
          map='<leader>cf'
        }
    }
})
```

Optionally you can add telescope options in `telescope` section in `maps`
with key `telescope_opts`

### Next theme

```vim
:CscNext
```

Or following defaults mapping

```vim
<leader>cl
```

### Previous theme

```vim
:CscPrev
```

Or following defaults mapping

```vim
<leader>ch
```

### (telescope required) search your theme

```vim
:CscTelescope
```

Or following defaults mapping

```vim
<leader>cf
```

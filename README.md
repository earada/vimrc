VIMRC
=====

Description
-----------
This repository contains my personal Neovim configuration (`init.lua`) and
some syntax files that I used to use:
 * ens.vim 88110 assembler syntax file.
 * yar.vim syntax highlighter for yara rules.

Install
-------
Symlink `init.lua` into the Neovim config directory. Plugins are managed with
[lazy.nvim](https://github.com/folke/lazy.nvim) and are installed automatically
on first start; the lockfile `lazy-lock.json` lives next to `init.lua`.

	mkdir -p ~/.config/nvim
	ln -s "$PWD/init.lua" ~/.config/nvim/init.lua

Python tooling (pynvim, black) is expected in a virtualenv at
`~/.config/nvim/.venv`.

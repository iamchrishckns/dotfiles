local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})

	print("Installing packer. Close and reopen Neovim again...")

	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand: Reload Neovim whenever you the packer.lua file gets saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Install your plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use { "wbthomason/packer.nvim" } 

  -- Useful lua functions used by lots of plugins
  use { "nvim-lua/plenary.nvim" }

	-- Colorscheme
	use 'mofiqul/dracula.nvim'

  -- Telescope
	use { 
    "nvim-telescope/telescope.nvim", 
    branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Statusbar
  use 'feline-nvim/feline.nvim'

	-- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)
    -- packer plugin alway on first place
    use("wbthomason/packer.nvim")
    -- naccessary lua functions for plugins
    use("nvim-lua/plenary.nvim")
    -- tmux pluging to navigate between split windows woth ctrl+hjkl
    use("christoomey/vim-tmux-navigator")
    -- toggle maximizer split window
    use("szw/vim-maximizer")
    -- color scheme theme
    use{"bluz71/vim-nightfly-colors", as = "nightfly"} -- color scheme
    -- comment plugin g+c+c = toggle one line comment. g+c+12+j = toggle comment for 12 lines below
    use("numToStr/Comment.nvim")
    -- file explorer plugin
    use("nvim-tree/nvim-tree.lua")
    if packer_bootstrap then
        require("packer").sync()
    end
end)

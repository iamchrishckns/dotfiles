local options = { 
  guicursor = "",
  
  nu = true,
  relativenumber = true,
  
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  
  smartindent = true,
  
  wrap = false,
  
  hlsearch = false,
  incsearch = true,
  
  termguicolors = true,
  
  scrolloff = 8,
  
  updatetime = 50,
}

-- Apply all options
for k, v in pairs(options) do
  vim.opt[k] = v
end

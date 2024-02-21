return {
  'lervag/vimtex',
  config = function()
    vim.cmd([[
      let g:vimtex_view_method = 'zathura'
      let g:vimtex_view_general_viewer = 'zathura'
      let g:vimtex_view_enabled=1
      let g:vimtex_compiler_engine = 'lualatex'
    ]])
  end

}

-- vim.cmd("let g:mkdp_auto_start = 0")
-- vim.cmd("let g:mkdp_auto_close = 1")
-- vim.cmd("let g:mkdp_refresh_slow = 0")
-- vim.cmd("let g:mkdp_command_for_global = 0")
-- vim.cmd("let g:mkdp_open_to_the_world = 0")
-- vim.cmd("let g:mkdp_open_ip = ''")
vim.cmd("let g:mkdp_browser = 'google-chrome-stable'")
-- vim.cmd("let g:mkdp_echo_preview_url = 0")
-- vim.cmd("let g:mkdp_browserfunc = ''")
-- vim.api.nvim_exec([[
   -- let g:mkdp_preview_options = {
    -- \ 'mkit': {},
    -- \ 'katex': {},
    -- \ 'uml': {},
    -- \ 'maid': {},
    -- \ 'disable_sync_scroll': 0,
    -- \ 'sync_scroll_type': 'middle',
       -- \ 'hide_yaml_meta': 1,
    -- \ 'sequence_diagrams': {},
    -- \ 'flowchart_diagrams': {},
    -- \ 'content_editable': v:false,
    -- \ 'disable_filename': 0
    -- \ }]],
    -- true)
-- vim.cmd("let g:mkdp_markdown_css = ''")
-- vim.cmd("let g:mkdp_highlight_css = ''")
-- vim.cmd("let g:mkdp_port = ''")
-- vim.cmd("let g:mkdp_page_title = '「${name}」'")
--vim.cmd("let g:mkdp_filetypes = ['markdown']")





--key

vim.cmd("autocmd Filetype markdown inoremap h1 <h1><+></h1><Esc>/<+><CR>:nohlsearch<CR>c3l")
vim.cmd("autocmd Filetype markdown inoremap h2 <h2><+></h2><Esc>/<+><CR>:nohlsearch<CR>c3l")
vim.cmd("autocmd Filetype markdown inoremap h3 <h3><+></h3><Esc>/<+><CR>:nohlsearch<CR>c3l")
vim.cmd("autocmd Filetype markdown inoremap h4 <h4><+></h4><Esc>/<+><CR>:nohlsearch<CR>c3l")

vim.cmd("autocmd Filetype markdown inoremap pb <p><b><+></b></p><Esc>/<+><CR>:nohlsearch<CR>c3l")
vim.cmd("autocmd Filetype markdown inoremap p1 <p> &nbsp; &nbsp; &nbsp; &nbsp; <+></p><Esc>/<+><CR>:nohlsearch<CR>c3l<CR><CR><Esc>ki<Space><Space>")



vim.cmd("autocmd Filetype markdown inoremap c0 <code><+></code><Esc>/<+><CR>:nohlsearch<CR>c3l")
vim.cmd("autocmd Filetype markdown inoremap c9 ```<CR><+>```<Esc>/<+><CR>:nohlsearch<CR>c3l<CR><Esc>kk$a")

vim.cmd("autocmd Filetype markdown inoremap a0 <a href=\"\" target=\"_blank\"><+></a><Esc>/<+><CR>:nohlsearch<CR>c3l")

vim.cmd("autocmd Filetype markdown inoremap u1 <ul><li><+></li></ul><Esc>/<+><CR>:nohlsearch<CR>c3l")
vim.cmd("autocmd Filetype markdown inoremap u2 <ul><ul><li><+></li></ul></ul><Esc>/<+><CR>:nohlsearch<CR>c3l")

vim.cmd("autocmd Filetype markdown inoremap o1 <ol><li><+></li></ol><Esc>/<+><CR>:nohlsearch<CR>c3l")
vim.cmd("autocmd Filetype markdown inoremap o2 <ol><ol><li><+></li></ol></ol><Esc>/<+><CR>:nohlsearch<CR>c3l")

vim.cmd("autocmd Filetype markdown inoremap s0 <s><+></s><Esc>/<+><CR>:nohlsearch<CR>c3l")


vim.cmd("autocmd Filetype markdown inoremap d1 <details><summary><b><+></b></summary></details><Esc>/<+><CR>:nohlsearch")
vim.cmd("autocmd Filetype markdown inoremap d0 <details><-><summary><!><b><+></b><@></summary><#></details><Esc>/<-><CR>:nohlsearch<CR>a<Esc>df>i<CR><Space><Space><Esc>/<!><CR>:nohlsearch<CR>a<Esc>df>i<CR><Space><Space><Esc>/<@><CR>:nohlsearch<CR>a<Esc>df>i<CR><BS><Esc>/<#><CR>:nohlsearch<CR>a<Esc>df>i<CR><BS><Esc>kk/<+><CR>:nohlsearch<CR>c3l") 

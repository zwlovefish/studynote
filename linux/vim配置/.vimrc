filetype plugin indent on
execute pathogen#infect()
syntax on

"********************************************************************设置NERDTree
" 设置F2打开和关闭项目树
map <F2> : NERDTreeToggle<CR>
"设置NERDTree的位置
let NERDTreeWinPos = 'left'
"=================================================================


"********************************************************************设置tagbar
"设置F4打开Tagbar
map <F4> : TagbarToggle<CR>
"设置宽度，默认为40
let g:tarbar_width = 40
let g:tarbar_right = 1

"××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××××设置YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' "配置全局路径
let g:ycm_confirm_extra_conf=0 "每次加载该文件，不提示是否要加载
let g:ycm_collect_identifiers_from_tag_files = 1
set completeopt-=preview
let g:ycm_confirm_extra_conf=0
let g:ycm_complete_in_comments=1
let g:ycm_error_symbol='>>'
let g:ycm_min_num_of_chars_for_completion=1


"********************************************************************设置ctags快捷键
"按下F5重新生成tag文件，并更新taglist
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
imap <F5><ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set tags=tags
set tags+=./tags "表示在当前工作目录下搜索tags文件


"********************************************************************设置taghighlight
hi CTagsGlobalVariable ctermfg = 5  "修改全局变量
hi CTagsMember ctermfg=38  "修改结构体成员



"********************************************************************设置ack.vim快速查找
map <C-f> : Ack -i<CR>

"==========================================vim一般的配置
set nu
set autoindent
set cindent
set smartindent
set tabstop=4
set shiftwidth=4
set ruler
set mouse=a


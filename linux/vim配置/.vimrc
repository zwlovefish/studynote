"基本配置
set nu "设置显示行号
set backspace=2 "能使用backspace回删
syntax on "语法检测
set ruler "显示最后一行的状态
set bg=dark "背景色设置
set hlsearch "高亮度反白
set laststatus=2 "两行状态行+一行命令行
set cindent "设置c语言自动对齐
set t_Co=256 "指定配色方案为256
set mouse=a "设置可以在VIM使用鼠标
set tabstop=4 "设置TAB宽度
set history=1000 "设置历史记录条数
set nocompatible "设置不兼容

"PATHOGEN配置
execute pathogen#infect()
filetype plugin on "允许插件
filetype plugin indent on "启动智能补全

"----------------------ctags配置---------------------------------
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=tags
set tags+=./tags "add current directory's generated tags file
"添加新的tags文件
"set tags += path

"----------------------taglist配置信息--------------------------
let Tlist_Auto_Open=1 " 让taglist自动打开
let Tlist_Auto_Update=1 "自动更新taglist
let Tlist_Compact_Format=1 "隐藏帮助菜单
let Tlist_Ctags_Cmd='ctags'
let Tlist_Enable_Fold_Column=0 "do show folding tree
let Tlist_Process_File_Always=1 " Always process the source file
let Tlist_Show_One_File=1 " Only show the tag list of current file
let Tlist_Exist_OnlyWindow=1 " If you are the last, kill yourself
let Tlist_File_Fold_Auto_Close=0 " Fold closed other trees
let Tlist_Sort_Type="name" " Order by name
let Tlist_WinWidth=40 " Set the window 40 cols wide.
"let Tlist_Close_On_Select=1 " Close the list when a item is selected
let Tlist_Use_SingleClick=1 "Go To Target By SingleClick
let Tlist_Use_Right_Window=1 "在右侧显示
"打开关闭快捷键
map <silent> <F4> :TlistToggle<CR> 

"----------------------cscope配置-----------------------------
if has("cscope")
    set csprg=/usr/bin/cscope
    set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
    " check cscope for definition of a symbol before checking ctags:
    set csto=1 " set to 1 if you want the reverse search order.
     if filereadable("cscope.out")
         cs add cscope.out
         " else add the database pointed to by environment variable
     elseif $CSCOPE_DB !=""
         cs add $CSCOPE_DB
    endif
    " show msg when any other cscope db added
    set cscopeverbose
    
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
set cscopequickfix=s-,c-,d-,i-,t-,e-  "使用quickfix来显示cscope结果

"-------------------NEARDTree配置-----------------------------
map <F2> :NERDTreeMirror <CR> 
map <F2> :NERDTreeToggle <CR>   
let NERDChristmasTree=1 "显示增强
let NERDTreeAutoCenter=1 "自动调整焦点
let NERDTreeShowFiles=1 "显示文件
let NERDTreeShowLineNumbers=1 "显示行号
let NERDTreeHightCursorline=1 "高亮当前文件
let NERDTreeShowHidden=0 "显示隐藏文件
let NERDTreeMinimalUI=0 "不显示'Bookmarks' label 'Press ? for help'
let NERDTreeWinSize=31 "窗口宽度

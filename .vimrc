let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"set termguicolors
syntax on
colorscheme molokai
set t_Co=256
set bg=dark

"コメント色の設定"
hi Comment ctermfg=249

"括弧等の補完
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"vnoremap { "zdi^V{<C-R>z}<ESC>
"vnoremap [ "zdi^V[<C-R>z]<ESC>
"vnoremap ( "zdi^V(<C-R>z)<ESC>
"vnoremap " "zdi^V"<C-R>z^V"<ESC>
"vnoremap ' "zdi'<C-R>z'<ESC>


"タブ/インデントの設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する


"ファイル関連の設定
filetype on
filetype indent on
filetype plugin on
set fenc=utf-8      "文字コードをutf-8にする

"画面表示の設定
set number             " 行番号を表示する
set cursorline         " カーソル行の背景色を変える
highlight CursorLine ctermbg=237  "カーソル行の背景色
highlight Visual ctermbg=237      "選択範囲の背景色
"set cursorcolumn      " カーソル位置のカラムの背景色を変える
set laststatus=2       " ステータス行を常に表示
set cmdheight=2        " メッセージ表示欄を2行確保
set showmatch          " 対応する括弧を強調表示
set helpheight=999     " ヘルプを画面いっぱいに開く
set list               "タブ、空白、改行の可視化
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%
set virtualedit=onemore "行末の1文字先までカーソルを移動できるように


"検索
set ignorecase     "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set incsearch      "検索文字列入力時に順次対象文字列にヒットさせる
set wrapscan       "検索時に最後まで行ったら最初に戻る
set hlsearch       "検索語をハイライト表示↲
set pastetoggle=<F2> "ペーストモード切り替え


"カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

"全角スペースをハイライト表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif


" ファイル処理関連の設定
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   " 外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない


"マウスの入力を受け付ける
"set mouse=a


"ノーマルと挿入モードでカーソル変える
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


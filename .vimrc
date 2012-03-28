set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
" Bundle "snipmate-snippets"
Bundle "honza/snipmate-snippets"
Bundle "garbas/vim-snipmate"

Bundle 'tomasr/molokai'

set encoding=utf8                       "デフォルトエンコード
set fileencodings=iso-2022-jp,sjis,euc-jp "自動判別するエンコード
set hlg=ja

set cindent                             "C言語風インデント
set cinoptions=g0                       "インデントスタイルの設定。g0でC++のアクセス修飾子のインデントを抑制
set smartindent                         "スマートインデント
set directory=$HOME/.vimbackup          "バックアップフォルダの位置
set title                               "タイトルバーにファイル名などを表示

set expandtab                           "タブを入力したらスペースにする
set backspace=indent,eol,start          "挿入モードでBackspace押すと一文字消す
set showmatch                           "括弧の対応を表示
set matchtime=1                         "括弧の対応を表示する時間（1/10秒単位）
set clipboard=unnamed                   "windowsと同じクリップボードを使用

set tabstop=2                           "タブ幅
set shiftwidth=2                        "インデント幅
set number                              "行番号の表示
set ruler                               "カーソルの現在位置を右下に表示
"set list                                "タブ文字や改行の可視化
set shellslash                          "フォルダの区切り文字にスラッシュを使用

set hlsearch                            "検索にマッチしたものをハイライト
set incsearch                           "インクリメンタルサーチを使う
set smartcase                           "検索内容に大文字を含むときのみ大文字小文字を区別
set grepprg=grep\ -nH\ $*               "外部grepを使う

syntax on                               "シンタックスハイライトを使う
filetype on                             "ファイルの種類ごとにプラグインを適用できるようにする?
filetype plugin on
filetype plugin indent on
filetype indent on
autocmd! BufRead,BufNewFile *.cgi set filetype=perl "*.cgiはperlですし

set t_Co=256                            "色数
colorscheme molokai                      "カラースキーマ

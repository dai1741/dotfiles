HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e

# 特殊キーを動作させる
# from https://wiki.archlinux.org/index.php/Zsh#Key_Bindings
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# from: http://stackoverflow.com/a/1099777/897061
bindkey '^[[1;5D'   backward-word           # ctrl+left
bindkey '^[[1;5C'   forward-word            # ctrl+right

# undo and redo like windows explorer
# You can find a bindable key representation corresponding to the key
# with a method described in: http://stackoverflow.com/a/2019377/897061
bindkey "^[[1;3D" undo  # alt+left
bindkey "^[[1;3C" redo  # alt+right

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dai/.zshrc'

autoload -Uz compinit
compinit -u

# see: http://news.mynavi.jp/column/zsh/index.html

autoload -U colors && colors
PROMPT="
%{$fg[green]%}(%n@%m)[%h]%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%}
%# "


setopt list_rows_first            # 補完候補リストを横方向に表示
setopt correct                    # 誤植を修正する
setopt prompt_subst               # プロンプト文字列の変数展開を表示毎に実行

setopt mark_dirs                  # ディレクトリ補完時に末尾にスラッシュを付ける
setopt complete_in_word           # 入力の末尾でなくても補完する
setopt magic_equal_subst          # "anything=expression"のような=以降の部分でも補完
setopt auto_param_keys            # 括弧や変数名を補完する

setopt auto_pushd                 # cd時にもといたディレクトリを自動pushd
setopt pushd_ignore_dups          # 直前と同じディレクトリを自動pushdしない
setopt auto_cd                    # ディレクトリ名を入力したときcdコマンドを発動
setopt auto_list                  # あいまい補完ですぐに補完候補を表示
setopt auto_menu                  # 2回以上連続で補完候補を読むと補完候補リストを表示？
unsetopt menu_complete            # 補完があいまいでもすぐに1番目の候補を補完

eval `dircolors -c`
# カーソルキーで補完候補を選べるようにする
zstyle ':completion:*:default' menu select=1

# smart case completion （小文字を大文字にも）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
alias ls='ls --color=auto -F'

setopt extendedglob               # 拡張ファイル名展開を行う

setopt extended_history           # 履歴に終了時刻を追加
setopt hist_ignore_dups           # 直前と同じコマンドを記録しない
setopt hist_ignore_space          # スペースで始まるコマンドは履歴に追加しない
setopt hist_reduce_blanks         # 不要なスペースを履歴から削除する
setopt hist_no_store              # historyコマンドは記録しない
setopt append_history             # histファイルを上書きせず追記
setopt share_history              # 複数zshで履歴を共有
setopt inc_append_history         # インクリメンタル履歴追記？
setopt hist_verify                # bang_histしたときに直接コマンドを実行しない


# http://qiita.com/items/8d5a627d773758dd8078

autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' max-exports 1
zstyle ':vcs_info:*' formats '(%s)-[%b]'  # VCS名とブランチ名

function _update_vcs_info_msg() {
  local messages
  LANG=en_US.UTF-8 vcs_info

  if [[ -z ${vcs_info_msg_0_} ]]; then
    # vcs_info で何も取得していない場合は何もしない
  else
    # vcs_info で情報を取得した場合　緑で表示する
    [[ -n "$vcs_info_msg_0_" ]] && messages=( "%F{green}${vcs_info_msg_0_}%f" )
    RPROMPT="$messages"
  fi
}

add-zsh-hook precmd _update_vcs_info_msg


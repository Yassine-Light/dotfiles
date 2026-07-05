# =========================================================
# fzf
# =========================================================

export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'  # strip-cwd-prefix removes the leading ./ from results

# Ctrl-T uses fd
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# UI
export FZF_DEFAULT_OPTS='
  --height=60%
  --layout=reverse
  --border=rounded
  --prompt="  "
  --pointer="  "
  --preview-window=right:65%:wrap:border-left
'

export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"


# Ctrl+G: live content search with ripgrep
_fzf_rg_live() {
  local result file
  result=$(fzf --phony \
        --bind 'change:reload:rg --line-number --no-heading --color=always {q} 2>/dev/null || true' \
        --ansi --delimiter=: \
        --preview 'bat --color=always --style=plain,numbers {1} --highlight-line {2}' \
        --preview-window 'right:65%:wrap:border-left')
  file=$(echo "$result" | cut -d: -f1)
  [[ -n "$file" ]] && LBUFFER+="$file"
  zle reset-prompt
}
zle -N _fzf_rg_live

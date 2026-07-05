# =======================
#  CS go type shit
# =======================

#remap fzf ctrl+t to ctrl+p
bindkey -r '^T'
bindkey '^P' fzf-file-widget

#search for files and their content
bindkey '^G' _fzf_rg_live

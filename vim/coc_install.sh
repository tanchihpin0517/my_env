extensions=(
    "coc-explorer"
    "coc-tabnine"
    "coc-highlight"
    "coc-snippets"
)
e_string=""

for e in ${extensions[@]}; do
    e_string="$e $e_string"
done

rm -r ~/.config/coc/extensions
nvim -c "CocInstall $e_string"

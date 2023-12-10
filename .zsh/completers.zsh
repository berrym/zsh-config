cd $COMPLETERS_DIR
local -a completion_funcs=(`ls`)
for f in $completion_funcs; do
    [[ -r $f ]] && . ./$f
done
popd

_lab() {
    cd $LAB_DIR
    local -a subdirs=(`ls -Rd */ | sed '/"-f"/d' && ls -Rd */*/ | sed '/"-f"/d' | sort -u`)
    compadd -X "%{$fg[cyan]%}completing %Blab projects%b%{$reset_color%}" -a subdirs
    popd
}

compdef -a _lab lab

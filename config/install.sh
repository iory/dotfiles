#!/bin/bash

abs_dirname() {
    local cwd="$(pwd)"
    local path="$1"

    while [ -n "$path" ]; do
        cd "${path%/*}"
        local name="${path##*/}"
        path="$(readlink "$name" || true)"
    done

    pwd -P
    cd "$cwd"
}

script_dir="$(abs_dirname "$0")"
mkdir -p ~/.config/fcitx
ln -sfh $script_dir/fcitx/config ~/.config/fcitx/config
ln -sfh $script_dir/fcitx/conf ~/.config/fcitx/conf

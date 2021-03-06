#!/usr/bin/env bash -e

install_homebrew() {
    ! which brew >/dev/null && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

update_shells() {
    if ! grep '/usr/local/bin/bash' /etc/shells; then
        echo Requesting sudo access to add /usr/local/bin/bash to /etc/shells
        sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    fi
}

brew_install() {
    brew install \
        autojump \
        bash \
        colordiff \
        diff-so-fancy \
        fzf \
        git \
        jq \
        node \
        tree
}

brew_cask_install() {
    brew cask install \
        aerial \
        alfred \
        docker \
        flycut \
        sizeup \
        spotify
}

install_n() {
    rm -rf /tmp/install-n && mkdir /tmp/install-n && cd /tmp/install-n
    git clone https://github.com/tj/n .
    PREFIX=~/n make install
    cd - && rm -rf /tmp/install-n
}

get_apps() {
    find . -type d -depth 1 -not -path './.*' | sed 's|./||' | xargs
}

backup() {
    apps="$(get_apps)"
    for app in $apps; do
        cd "$app"
        OIFS="$IFS"
        IFS=$'\n'
        files="$(find . -type f | sed 's|./||')"
        for file in $files; do
            echo "cp ~/${file} ./${app}/${file}"
            cp "$HOME/${file}" "${file}"
        done
        IFS="$OIFS"
        cd ..
    done
}

restore() {
    apps="$(get_apps)"
    for app in $apps; do
        cd "$app"
        OIFS="$IFS"
        IFS=$'\n'
        files="$(find . -type f | sed 's|./||')"
        for file in $files; do
            echo "cp ./${app}/${file} ~/${file}"
            cp "${file}" "$HOME/${file}"
        done
        IFS="$OIFS"
        cd ..
    done
}

check_files_are_the_same() {
    apps="$(get_apps)"
    for app in $apps; do
        cd "$app"
        OIFS="$IFS"
        IFS=$'\n'
        files="$(find . -type f | sed 's|./||')"
        for file in $files; do
            echo "diff $HOME/${file} ${app}/${file}"
            diff "$HOME/${file}" "${file}"
        done
        IFS="$OIFS"
        cd ..
    done
}

if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
    install_homebrew
    brew_install
    brew_cask_install
    install_n
    update_shells
    restore
    open .etc/ayu_light.terminal
fi

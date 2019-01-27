#!/usr/bin/env bash -e

install_homebrew() {
    ! which brew >/dev/null && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

update_shells() {
    if ! grep '/usr/local/bin/bash' /etc/shells; then
        sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    fi
}

brew_install() {
    brew install \
        autojump \
        bash \
        diff-so-fancy \
        fzf \
        peco
}

brew_cask_install() {
    brew cask install \
        alfred \
        caffeine \
        docker \
        dropbox \
        flycut \
        sizeup \
        spotify \
        sublime-text \
        visual-studio-code
}

setup_from_repo() {
    apps="$(find . -type d -depth 1 | sed 's|./||' | xargs)"
    for app in $apps; do
        cd "$app"
        OIFS="$IFS"
        IFS=$'\n'
        files="$(find . -type f | sed 's|./||')"
        for file in $files; do
            echo "mv ~/${file} ~/${file}.bak"
            mv ~/${file} ~/${file}.bak
            echo "ln -s ${app}/${file} $HOME/${file}"
            ln -s "${PWD}/${file}" "$HOME/${file}"
        done
        IFS="$OIFS"
        cd ..
    done
}

copy_to_repo() {
    apps="$(find . -type d -depth 1 | sed 's|./||' | xargs)"
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

check_files_are_the_same() {
    apps="$(find . -type d -depth 1 | sed 's|./||' | xargs)"
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

setup_backups_from_repo() {
    apps="$(find . -type d -depth 1 | sed 's|./||' | xargs)"
    for app in $apps; do
        cd "$app"
        OIFS="$IFS"
        IFS=$'\n'
        files="$(find . -type f | sed 's|./||')"
        for file in $files; do
            echo "cp ${app}/${file} $HOME/${file}.bak"
            cat "${file}" > "$HOME/${file}.bak"
        done
        IFS="$OIFS"
        cd ..
    done
}

# install_homebrew
# brew_install
# brew_cask_install
# update_shells
# copy_to_repo
# check_files_are_the_same
# copy_to_repo
# setup_from_repo
# setup_backups_from_repo

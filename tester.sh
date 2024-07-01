#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

current_dir=$PWD

# check for updates
version=68

ALIASES='
alias francinette="$HOME/francinette/tester.sh"
alias paco="$HOME/francinette/tester.sh"
'

search_alias=$(cat ~/.zshrc | grep paco | wc -l )

if [ $search_alias -eq 0 ];then
	echo "$ALIASES" >> ~/.zshrc
fi

is_package_installed() {
    python3 -c "import $1" &> /dev/null
}

# Instalación de paquetes solo si no están instalados
install_if_not_installed() {
    package=$1
    if ! is_package_installed $package; then
        pip3 install $package > /dev/null 2>&1
    fi
}

# Verificar e instalar los paquetes necesarios
install_if_not_installed GitPython
install_if_not_installed halo
install_if_not_installed rich
install_if_not_installed toml

cd "$current_dir" || exit
#source "$DIR"/venv/bin/activate

python3 "$DIR"/main.py "$@"

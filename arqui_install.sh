#!/bin/bash
# Dependencies: DOCKER

function install_container() {
    read -p "Please choose a name for the container: " DOCK_NAME
  
    if [[ ! $DOCK_NAME =~ ^[a-zA-Z0-9]{3,20}$ ]] ; then
        echo "Invalid container name format."
        exit 1
    fi

    docker pull agodio/itba-so:1.0
    docker run -d -v ${PWD}:/root --security-opt seccomp:unconfined -ti --name $DOCK_NAME agodio/itba-so:1.0
    docker start $DOCK_NAME
    BASHRC_CONTENT=$(cat <<EOF
    export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
    PS1='\[\033[01;36m\]@\w \$\[\033[00m\] '
    alias ls='ls --color=auto'
    cd /root
EOF
)
   
    echo "$BASHRC_CONTENT" > .bashrc
}

# Create 'arquid' alias to run container.
function create_arquid() {

    SHELL_NAME="${SHELL#*/bin/}"
    local rc_file
    case "$SHELL_NAME" in
        bash) rc_file=".bashrc" ;;
        zsh)  rc_file=".zshrc"  ;;
        *)    echo "Shell configuration not found. Note: temp works only on zsh or bash."
        return ;;
    esac

    echo 'alias arquid="docker start ARQUI_DOCKER ; docker exec -ti ARQUI_DOCKER bash" >> $HOME/.bashrc' >> $HOME/$rc_file
    echo "Alias 'arquid' created successfully."
}

# Install ARQUI_DOCKER
if [[ $EUID -ne 0 ]] ; then
    read -r -p "Install ARQUI_DOCKER and its dependencies? [y/N]" response
    if [[ "$response" =~ ^[yY]$ ]] ; then
        install_container
        read -r -p "Create an alias to run container as 'arquid' in termina;? [y/N]" response
            if [[ "$response" =~ ^[yY]$ ]] ; then
                create_arquid
            fi
    echo "Executing docker container..."
    docker exec -ti $DOCK_NAME bash
    else
        exit 1
    fi
else
    echo "Please install as a user."
    exit 1
fi


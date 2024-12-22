#!/bin/bash

while true; do
    clear
    read -p "Connect to SFTP? Y/N: " sftp
    if [[ "$sftp" == "exit" ]]; then
        exit
    fi

    read -p "Username: " user
    if [[ "$user" == "exit" ]]; then
        exit
    fi

    read -p "Port: " port
    if [[ "$port" == "exit" ]]; then
        exit
    fi

    read -p "URL: " url
    if [[ "$url" == "exit" ]]; then
        exit
    fi

    read -p "Login (1) or PEM (2): " auth
    if [[ "$auth" == "exit" ]]; then
        exit
    fi

    if [[ "$auth" == "1" ]]; then
        if [[ "${sftp,,}" == "y" ]]; then
            gnome-terminal -- bash -c "sftp -P $port $user@$url; exec bash"
        fi
        ssh -p "$port" "$user@$url"
    elif [[ "$auth" == "2" ]]; then
        if [[ "${sftp,,}" == "y" ]]; then
            gnome-terminal -- bash -c "sftp -P $port -i ../pem/$user.pem $user@$url; exec bash"
        fi
        ssh -p "$port" -i "../pem/$user.pem" "$user@$url"
    fi

    clear
    echo "Connection closed."
done

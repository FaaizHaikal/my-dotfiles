This repository contains my personal Linux Debian-based configurations, shell customizations, and my dev-environment.

## Initial Setup
1. Install basic tools
    ```sh
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y wget curl build-essential git unzip python3-pip python3-venv xclip
    ```
2. Setup Git
    ```sh
    git config --global user.name "{GIT_USERNAME}"
    git config --global user.email "{GIT_EMAIL}"
    ```

## Terminal Setup
1. Nerd Fonts
    ```sh
    mkdir -p ~/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuMono.zip
    unzip UbuntuMono.zip -d ~/.local/share/fonts/
    rm UbuntuMono.zip
    sudo fc-cache -f -v
    ```
2. Starship
    ```sh
    curl -sS https://starship.rs/install.sh | sh
    cp {path-to-my-dotfiles}/starship/starship.toml ~/.config
    ```
3. Shell Configurations (`.bashrc`)
    ```sh
    # History Settings
    HISTCONTROL=ignoreboth:erasedups
    HISTSIZE=3000
    HISTFILESIZE=5000

    # Arrow Key History Search
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'

    # Prompt
    eval "$(starship init bash)"
    ```

## Backend Environment
1. [Install Go](https://go.dev/doc/install)
2. PostgreSQL and Redis
    ```sh
    sudo apt update
    sudo apt install postgres redis-server
    ```
3. MinIO Community Edition
    - Installation
      ```sh
      # Install MinIO via Go
      go install github.com/minio/minio@latest
      sudo mv ~/go/bin/minio /usr/local/bin/

      # Create User and Directories
      sudo groupadd -r minio
      sudo useradd -M -r -g minio minio -s /sbin/nologin
      sudo mkdir -p /mnt/data
      sudo chown minio:minio /mnt/data
      ```
    - Configurations (`/etc/default/minio`)
      ```sh
      MINIO_VOLUMES="/mnt/data"
      MINIO_OPTS="--address :9000 --console-address :9001"
      MINIO_ROOT_USER="miniodev"
      MINIO_ROOT_PASSWORD="miniodev"
      ```
    - Systemd Service (`/etc/systemd/system/minio.service`)
      ```sh
      [Unit]
      Description=MinIO
      Documentation=https://docs.min.io
      Wants=network-online.target
      After=network-online.target
      AssertFileIsExecutable=/usr/local/bin/minio

      [Service]
      WorkingDirectory=/usr/local/
      User=minio
      Group=minio
      ProtectProc=invisible
      EnvironmentFile=/etc/default/minio
      ExecStart=/usr/local/bin/minio server $MINIO_OPTS $MINIO_VOLUMES

      Restart=always
      LimitNOFILE=65536

      [Install]
      WantedBy=multi-user.target
      ```

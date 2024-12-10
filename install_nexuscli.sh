#!/bin/bash

# Bước 1: Cập nhật và nâng cấp hệ thống
echo "Bước 1: Cập nhật hệ thống..."
sudo apt update && sudo apt upgrade -y

# Bước 2: Cài đặt các gói cần thiết
echo "Bước 2: Cài đặt các gói build-essential, pkg-config, libssl-dev, git-all..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y build-essential pkg-config libssl-dev git-all

# Bước 3: Cài đặt Rust
echo "Bước 3: Cài đặt Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Bước 4: Chạy Nexus CLI lần đầu để xác định lỗi
echo "Bước 4: Chạy Nexus CLI lần đầu..."
curl https://cli.nexus.xyz/ | sh || echo "Lỗi được xác định, tiếp tục cài protobuf-compiler..."

# Bước 5: Cập nhật lại hệ thống
echo "Bước 5: Cập nhật lại hệ thống..."
sudo apt update -y

# Bước 6: Cài đặt protobuf-compiler
echo "Bước 6: Cài đặt protobuf-compiler..."
sudo DEBIAN_FRONTEND=noninteractive apt install -y protobuf-compiler

# Bước 7: Hiển thị biến PATH để kiểm tra
echo "Bước 7: Kiểm tra PATH hiện tại..."
echo $PATH

# Bước 8: Chạy lại Nexus CLI để hoàn tất
echo "Bước 8: Chạy Nexus CLI lần cuối để hoàn tất..."
curl https://cli.nexus.xyz/ | sh

echo "Hoàn tất cài đặt Nexus CLI!"

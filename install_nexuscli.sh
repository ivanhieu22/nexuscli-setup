#!/bin/bash

# Định nghĩa các màu
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
CYAN='\e[36m'
RESET='\e[0m'

# Bước 1: Cập nhật và nâng cấp hệ thống
echo -e "${BLUE}Bước 1: Cập nhật hệ thống...${RESET}"
export DEBIAN_FRONTEND=noninteractive
sudo sh -c "echo GRUB_DISABLE_OS_PROBER=true >> /etc/default/grub"
sudo update-grub
sudo DEBIAN_FRONTEND=noninteractive apt update -y && sudo DEBIAN_FRONTEND=noninteractive apt upgrade -

# Bước 2: Cài đặt các gói cần thiết
echo -e "${CYAN}Bước 2: Cài đặt các gói build-essential, pkg-config, libssl-dev, git-all...${RESET}"
sudo DEBIAN_FRONTEND=noninteractive apt install -y build-essential pkg-config libssl-dev git-all

# Bước 3: Cài đặt Rust
echo -e "${YELLOW}Bước 3: Cài đặt Rust...${RESET}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Bước 4: Chạy Nexus CLI lần đầu và tự động gửi thông tin "Y" bằng yes
echo -e "${RED}Bước 4: Chạy Nexus CLI lần đầu...${RESET}"
echo -e "Y\nY" | curl -sSfL https://cli.nexus.xyz/ | bash || echo -e "${RED}Lỗi được xác định, tiếp tục cài protobuf-compiler...${RESET}"

# Bước 5: Cập nhật lại hệ thống
echo -e "${BLUE}Bước 5: Cập nhật lại hệ thống...${RESET}"
sudo apt update -y

# Bước 6: Cài đặt protobuf-compiler
echo -e "${CYAN}Bước 6: Cài đặt protobuf-compiler...${RESET}"
sudo DEBIAN_FRONTEND=noninteractive apt install -y protobuf-compiler

# Bước 7: Hiển thị biến PATH để kiểm tra
echo -e "${YELLOW}Bước 7: Kiểm tra PATH hiện tại...${RESET}"
echo $PATH

# Bước 8: Chạy lại Nexus CLI để hoàn tất
echo -e "${GREEN}Bước 8: Chạy Nexus CLI lần cuối để hoàn tất...${RESET}"
curl https://cli.nexus.xyz/ | bash

# Nhắc nhở người dùng khởi động lại nếu cần
echo -e "${GREEN}Hoàn tất cài đặt Nexus CLI!${RESET}"
echo -e "${YELLOW}Designed by Ivan Hieu (http://t.me/ivanhieu22) ⚡${RESET}"

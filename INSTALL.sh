#!/bin/bash

set -e

# Function to download and extract vkvm.tar.gz
download_and_extract() {
    echo "Downloading and extracting vkvm.tar.gz..."
    wget -qO- /tmp https://github.com/Pymmdrza/WinOnLinux/raw/main/vkvm.tar.gz | tar xvz -C /tmp

}

# Function to download Windows ISO
download_windows_iso() {
    echo "Downloading Windows 10 ISO..."
    curl -fL https://cdn.s0ft.net/dl/iso/windows/Windows_10_Business_Multiple_Editions_22H2_19045_4046_MSDN_VL_x64.iso -o /tmp/win10.iso
}

# Function to select the drive
select_drive() {
    echo "Listing available drives..."
    lsblk
    echo
    read -p "Please enter the name of the drive you want to use (e.g., /dev/sda): " drive

    while true; do
        read -p "You selected $drive. Do you want to proceed with this drive? (Y/N): " yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) read -p "Please enter the name of the drive you want to use (e.g., /dev/sda): " drive;;
            * ) echo "Please answer yes (Y) or no (N).";;
        esac
    done

    echo "You have confirmed the drive: $drive"
}

# Function to run QEMU with the selected drive
run_qemu() {
    echo "Starting QEMU with the selected drive..."
    ./tmp/qemu-system-x86_64 -net nic -net user,hostfwd=tcp::3389-:3389 -m 10000M -localtime -enable-kvm -cpu core2duo,+nx -smp 2 -usbdevice tablet -k en-us -cdrom /tmp/win10.iso -hda $drive -vnc :1 -boot d
}

# Main script execution
main() {
    download_and_extract
    download_windows_iso
    select_drive
    run_qemu
}

main

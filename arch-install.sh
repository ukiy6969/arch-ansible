#!/bin/bash

loadkeys jp106

timedatectl set-ntp true

sgdisk --new 1::+512M /dev/sda
sgdisk --new 2:: /dev/sda

sgdisk -t 1:ef00 /dev/sda
sgdisk -t 2:8300 /dev/sda

sgdisk -c 1:'EFI system partition' /dev/sda
sgdisk -c 2:'Linux filesystem' /dev/sda

mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bk
grep -h -A1 '## Japan' /etc/pacman.d/mirrorlist.bk | sed -e '/^--/d' > /etc/pacman.d/mirrorlist

pacstrap /mnt base linux linux-firmware intel-ucode

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

hwclock --systohc

echo 'LANG=en_US.UTF-8' > /etc/locale.conf
cat <<EOF >> /etc/hosts
127.0.0.1	localhost
::1		localhost
EOF

bootctl install

cat <<EOF > /boot/loader/loader.conf 
default  arch
timeout  4
editor   no
EOF

e2label /dev/sda2 arch_os

cat <<EOF > /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=LABEL=arch_os rw
EOF

cat <<EOF /etc/systemd/network/20-wired.network
[Match]
Name=eth0

[Network]
DHCP=ipv4
EOF

pacman -S xf86-video-fbdev

#!/bin/sh
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3 
mount /dev/sda3 /mnt
pacstrap /mnt base base-devel linux linux-firmware networkmanager vim git sudo grub efibootmgr dosfstools os-prober mtools xorg xorg-server xfce4 xfce4-goodies lightdm lightdm-gtk-greeter firefox engrampa neofetch
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
git clone https://github.com/emiliamity/archinstall
cd archinstall/
chmod 777 ward.sh
./ward.sh
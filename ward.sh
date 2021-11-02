#!/bin/bash
ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime
hwclock --systohc
echo Arch >> /etc/hostname
echo en_US.UTF-8 >> /etc/locale.gen
locale-gen
echo 127.0.0.1	localhost >> /etc/hosts
echo ::1	localhost >> /etc/hosts
echo 127.0.1.1	Arch.localdomain	Arch
useradd -m -G wheel amity
echo Enter the root account password
passwd
echo Enter the user account password
passwd amity
mkinitcpio -P
systemctl enable NetworkManager
systemctl enable lightdm
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
neofetch
exit
umount -l /mnt
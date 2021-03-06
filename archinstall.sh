#!/bin/sh
fdisk /dev/sda
n
p
1

+256M
n
p
2

+1G
n
p
3


a
1
w
q
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3 
mount /dev/sda3 /mnt
pacstrap /mnt base base-devel linux linux-firmware networkmanager vim git sudo grub efibootmgr dosfstools os-prober mtools xorg xorg-server xfce4 xfce4-goodies lightdm lightdm-gtk-greeter firefox engrampa neofetch
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
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
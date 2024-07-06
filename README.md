# WinOnLinux

Run and Install Windows OS on Linux Terminal with KVM

## Step 1: Download and Extract vkvm.tar.gz

```bash
curl -fL https://github.com/Pymmdrza/WinOnLinux/raw/main/vkvm.tar.gz -o /tmp/vkvm.tar.gz && \
tar -xzvf /tmp/vkvm.tar.gz -C /tmp && \
rm /tmp/vkvm.tar.gz
```
## Step 2: Download Windows ISO (Direct Link)

```bash

curl -fL https://cdn.s0ft.net/dl/iso/windows/Windows_10_Business_Multiple_Editions_22H2_19045_4046_MSDN_VL_x64.iso -o /tmp/win10.iso
```

More about Windows 10 ISO file or download another version follow [this Link](https://s0ft.net/windows-10-business-editions-22h2-build-19045-4291-vl-activation.html 'Windows 10 Business Editions 22H2 Build 19045.4291 VL + Activation')

## Step 3: Run QEMU with the Downloaded ISO

### SSD Type

```bash

./qemu-system-x86_64 -net nic -net user,hostfwd=tcp::3389-:3389 -m 10000M -localtime -enable-kvm -cpu core2duo,+nx -smp 2 -usbdevice tablet -k en-us -cdrom /tmp/win10.iso -hda /dev/sda -vnc :1 -boot d 
```
### NVME Type

```bash

./qemu-system-x86_64 -net nic -net user,hostfwd=tcp::3389-:3389 -m 10000M -localtime -enable-kvm -cpu core2duo,+nx -smp 2 -usbdevice tablet -k en-us -cdrom /tmp/win10.iso -hda /dev/nvme0n1 -vnc :1 -boot d 
```
To find the drive name, use `lsblk` to show all drives on the system. If you see a difference in the name of the drives, you can change this part according to the name of your drive: `-hda /dev/<NAME_YOUR_DRIVE_HERE>`

#!/bin/sh

DRIVE=~/Downloads/Rocky-10-GenericCloud-Base.latest.x86_64.qcow2
CPU=6
MEM=16384 # 16GB
# DISK=300G

# Create disk to install onto
# qemu-img create -f qcow2 "$DRIVE" "$DISK"

# Boot QEMU with ISO and disk
qemu-system-x86_64 \
  -enable-kvm \
  -machine type=q35,accel=kvm,smm=on \
  -cpu host,-hypervisor,vendor=GenuineIntel \
  -smp "$CPU" \
  -m "$MEM" \
  -boot d \
  -nic user,model=e1000e \
  -cdrom "$ISO" \
  -drive if=ide,index=0,file="$DRIVE",format=qcow2,media=disk \
  -vga std \
  -smbios type=0,vendor=AmericanMegatrends,version=2.20,uefi=on \
  -smbios type=1,manufacturer="Dell Inc.",product="PowerEdge R640",version=1.0,serial=ABC1234 \
  -display gtk,show-menubar=on,gl=off \
  -serial mon:stdio

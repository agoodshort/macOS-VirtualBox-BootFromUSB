# macOS-VirtualBox-BootFromUSB

This script will let you boot from a USB stick in a VirtualBox's VM with no hassle.

## Getting Started

### Prerequisites

- VirtualBox installed. You can download it directly from [VirtualBox.org](https://www.virtualbox.org/wiki/Downloads)
- Only one USB drive attached and mounted

### What does the script do?

The script will create a VMDK file pointing to your USB drive and attach it to your VM.
If running the script without editing the variables on the top of script, it will delete the previous VMDK attached to your VM and create a new one. This has to be done in case the USB location has changed.
 
## Usage

1. Clone the repo

```
git clone "https://github.com/agoodshort/macOS-VirtualBox-BootFromUSB.git"
```

2. Uncomment and rename the variable VM_NAME at the top of the script

```
vim macOS-VirtualBox-BootFromUSB/bootFromUSB.sh
```

3. Launch the script

```
./macOS-VirtualBox-BootFromUSB/bootFromUSB.sh
```
Your VM will start with your USB drive.

# macOS-VirtualBox-BootFromUSB

This script will let you boot from a USB stick in a VM of your VirtualBox app with no hassle.

## Getting Started

Please read through the steps below before running the bash scripts.

### What will happen

The script will create a VMDK file pointing to your USB hard drive and attach it to your VM.
When running the script for a second and you did not edit the variable name, it will delete the previous VMDK attached to your VM and create a new one. This has to be done in case the USB location has changed.

### Prerequisites

You will need VirtualBox already installed on your machine. You can download it directly from [VirtualBox.org](https://www.virtualbox.org/wiki/Downloads)

Make sure to edit the variable VM_NAME before launching the script. More details in the [Usage](https://github.com/goodshort/macOS-VirtualBox-BootFromUSB#Usage) section.

This script assumes you have only one USB drive attached to your computer and it has already been mounted before running the script.

### Usage

1. Download the git at the desired location

```
git clone "https://github.com/goodshort/macOS-VirtualBox-BootFromUSB.git"
```

2. Uncomment and rename the variable VM_NAME

```
vim macOS-VirtualBox-BootFromUSB/bootFromUSB
```

3. Launch the script

```
./macOS-VirtualBox-BootFromUSB/bootFromUSB
```
You VM will start with your USB drive.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

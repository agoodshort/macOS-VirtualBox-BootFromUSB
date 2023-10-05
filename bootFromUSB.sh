#!/bin/sh

## Edit the variable below to set the name of your VM
## This should match your VM name if you are not creating one
#VM_NAME="name-of-the-VM"

## Do not edit
USB_LOC="$(diskutil list | grep external | head -c 10)"
EXISTING_VM="$(vboxmanage list vms --long | grep "${VM_NAME}" | head -n 1 | cut -c 30-)"
BASEFOLDER="$(vboxmanage list systemproperties | grep folder | cut -c 34-)"
VMDK="${BASEFOLDER}/${VM_NAME}/usb_drive.vmdk"


if [ -n "${VMDK}" ] && [ -n "${VM_NAME}" ]; then
  ## Creating VM if VM_NAME doesn't match any of the existing VM
  if [ "${EXISTING_VM}" != "${VM_NAME}" ]; then
    echo ""
    echo "#######################################"
    echo "             Creating VM"
    echo "#######################################"

    VBoxManage createvm --name "${VM_NAME}" --ostype Debian --register
    VBoxManage modifyvm "${VM_NAME}" --vram 30 --memory 2048
    VBoxManage storagectl "${VM_NAME}" --name "IDE" --add ide --controller PIIX4

  else
    echo ""
    echo "#######################################"
    echo "         VM already exists"
    echo "#######################################"
  fi

  ## Attaching the USB drive to the VM
  echo ""
  echo "#######################################"
  echo "  Unmount and changing disk ownership"
  echo "#######################################"

  ## Get ownership of the disk, otherwise VirtualBox will prompt error message
  sudo chown $USER "${USB_LOC}"
  diskutil unmountdisk "${USB_LOC}"

  echo ""
  echo "#######################################"
  echo "   Removing any pre-existing VMDK"
  echo "#######################################"

  ## Remove previous vmdk
  VBoxManage storageattach "${VM_NAME}" --storagectl "IDE" --port 1 --device 1 --type hdd --medium none
  VBoxManage closemedium "${VMDK}" --delete
  rm -f "${VMDK}"

  echo ""
  echo "#######################################"
  echo "          Creating a new VMDK"
  echo "#######################################"

  ## Create and add new vmdk
  VBoxManage internalcommands createrawvmdk -filename "${VMDK}" -rawdisk "${USB_LOC}"
  VBoxManage storageattach "${VM_NAME}" --storagectl "IDE" --port 1 --device 1 --type hdd --medium "${VMDK}"

  echo ""
  echo "#######################################"
  echo "          Launching the VM"
  echo "#######################################"

  diskutil unmountdisk "${USB_LOC}"
  VBoxManage startvm "${VM_NAME}"

else
  echo ""
  echo "/!\  Edit the variables VMDK and VM_NAME before running the script /!\ "
fi
echo ""

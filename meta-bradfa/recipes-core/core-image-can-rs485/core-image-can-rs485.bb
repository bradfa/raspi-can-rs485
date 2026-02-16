SUMMARY = "CAN/RS-485 image for Raspberry Pi 5"
DESCRIPTION = "Minimal image for the CAN/RS-485 Raspberry Pi 5 platform."

inherit core-image

IMAGE_INSTALL:append = " \
    can-utils \
    coreutils \
    packagegroup-core-ssh-openssh \
    openssh-ssh \
"

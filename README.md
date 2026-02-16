# Raspberry Pi 5 CAN and RS-485 Yocto Build

Yocto Project build for a Raspberry Pi 5 running the
[Waveshare RS485/CAN HAT (B)](https://www.waveshare.com/wiki/RS485_CAN_HAT_(B)).
The HAT provides one CAN bus (MCP2515 via SPI0) and two RS-485 ports
(SC16IS752 via SPI1).

The image is a minimal, systemd-based Linux system with OpenSSH, intended as a
starting point for an application that communicates over CAN and RS-485.

## Repository layout

This repository uses a non-standard layout for convenience: `meta-bradfa` lives
directly in the repo alongside `build/conf/`, while the other layers
(`openembedded-core`, `meta-raspberrypi`, and `bitbake`) are included as git
submodules. This keeps everything self-contained in a single clone but is not a
pattern you would follow in a production Yocto project.

## Getting the source

```sh
git clone --recurse-submodules https://github.com/bradfa/raspi-can-rs485.git
```

If you have already cloned without `--recurse-submodules`, initialize the
submodules afterwards:

```sh
git submodule update --init --recursive
```

## Layers

| Layer | Purpose |
|---|---|
| `openembedded-core/meta` | OE-core (scarthgap) |
| `meta-raspberrypi` | Raspberry Pi BSP |
| `meta-bradfa` | Custom MACHINE, DISTRO, and image recipe |

## Build

Initialize the build environment and run BitBake:

```sh
source openembedded-core/oe-init-build-env build
bitbake core-image-can-rs485
```

The local.conf defaults for MACHINE and DISTRO are `raspi5-can-rs485` and
`can-rs485`, respectively.

The finished image is written to `build/tmp-glibc/deploy/images/raspi5-can-rs485/`.

## Flashing

Write the image to an SD card using `bmaptool` (replace `/dev/sdX` with the
correct device):

```sh
cd build/tmp-glibc/deploy/images/raspi5-can-rs485
bmaptool copy core-image-can-rs485-raspi5-can-rs485.rootfs.wic.bz2 /dev/sdX
```

`bmaptool` uses the accompanying `.bmap` file to skip empty blocks and verify
the write, making it faster and more reliable than a raw `dd`.

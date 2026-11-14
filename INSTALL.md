# Install and update

## Read this first

- Scope is RMX1931 / RMX1931CN `samurai` only.
- The project test unit is 8 GiB RAM.  6/12 GiB and 64/128/256 GB
  storage variants are not all validated.
- The bootloader must be unlocked.
- Do not use `fastboot boot`; the project's ABL rejected it.
- Do not write NV, persist, calibration or userdata.
- Keep an EDL/9008 recovery path and a known-good boot/logdump backup.

## Existing project installation: kernel update only

If the phone is already running the project's Linux system, update only
the kernel FAT (`logdump`).  Keep boot, DTB and rootfs unchanged.

On the phone, verify the downloaded file:

```sh
sha256sum logdump-touch-gpi.img
# expected:
# 125436109e7bb950bf608610ffc3dca656638764e695f52eda843eaf16d70dbb
```

GitHub-blocked networks can fetch the same asset through:

```sh
curl -fL \
  "https://ghfast.top/https://github.com/hmhmdcy/realme-x2-pro-releases/releases/latest/download/logdump-touch-gpi.img" \
  -o logdump-touch-gpi.img
```

Verify the hash after any mirror download; a mirror is not allowed to
change package or image bytes.

Use the Linux-side helper from the project:

```sh
sh flash-kernel-linux.sh \
  --kernel-fat logdump-touch-gpi.img \
  --sha256 125436109e7bb950bf608610ffc3dca656638764e695f52eda843eaf16d70dbb \
  --reboot
```

The helper resolves the GPT label `logdump`, refuses a mounted or
read-only target, verifies size/hash, writes the whole FAT image, reads
it back, and only then requests reboot.

## New installation: boot + logdump

This repository does not provide a ready-made rootfs.  See
[ROOTFS.md](ROOTFS.md) for the clean build path and the reasons a
maintainer's live system must not be redistributed.  Prepare a
compatible rootfs first, then flash the boot carrier and kernel FAT.

The matching modules archive is a separate release asset:

```text
modules-7.3.1-rmx1931-samurai-v731-usbwake-otg.tar.gz
SHA-256 5045c16b46928bc6ff9fbeb0418a21e34c12356954694665634c587006e19a02
```

It contains 772 modules and its extracted tree starts with
`7.3.1-rmx1931-samurai-v731-usbwake-otg/`.  Install it into
`/lib/modules/` before the first boot with this kernel, or the
rootfs may boot without Wi-Fi, Bluetooth, camera and other modules.

With fastboot:

```sh
fastboot flash logdump logdump-touch-gpi.img
fastboot flash boot boot-eud-production-off.img
fastboot reboot
```

`logdump` is written first.  Do not flash `boot` if the `logdump` write
failed.  Use GPT labels/`by-partlabel` in scripts where possible; do not
hardcode a `/dev/sdX` number from another machine.

The kernel release must match `/lib/modules`:

```text
7.3.1-rmx1931-samurai-v731-usbwake-otg
```

If the existing rootfs has modules from another release, install the
matching module tree before rebooting, or the affected modules will not
load.

Verify the module archive before extraction:

```sh
sha256sum modules-7.3.1-rmx1931-samurai-v731-usbwake-otg.tar.gz
tar -tzf modules-7.3.1-rmx1931-samurai-v731-usbwake-otg.tar.gz | head
```

Extract it with the leading release directory, then regenerate the
dependency cache on the device:

```sh
tar -xzf modules-7.3.1-rmx1931-samurai-v731-usbwake-otg.tar.gz \
  -C /lib/modules
depmod -a 7.3.1-rmx1931-samurai-v731-usbwake-otg
modprobe -n -v bnep uhid uinput
```

The last command only checks module resolution; it does not prove the
hardware works.  If `depmod` reports unresolved dependencies, stop and
reinstall the matching archive rather than mixing module trees.

## Verify after boot

```sh
uname -a
cat /proc/sys/kernel/random/boot_id
cat /proc/sys/kernel/tainted
/proc/bus/input/devices | grep -A2 'Synaptics S3706A'
dmesg | grep -E 'EV ALLOCATE|alloc_ev_chan|Failed to get rx DMA'
```

Expected: `#8`, boot ID changed, touch present, and zero GPI errors.
`taint=512` is a pre-existing warning state on the test unit and is not
by itself evidence of this update failing.

## What this release does not do

- It does not replace a rootfs.
- It does not contain the modules archive inside `logdump`; install the
  matching archive separately.
- It does not update userspace packages; use the APK repository.
- It does not fix suspend/deep-sleep or OTG physical host acceptance.
- It does not validate 6/12 GiB or 64/128/256 GB SKUs.

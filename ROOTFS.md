# Rootfs and module pairing

## Why there is no prebuilt rootfs here

The project's tested rootfs was built on a specific phone and contains
that installation's machine identity, account data, Wi-Fi profiles,
SSH host keys and calibration.  Publishing it as a release asset would
leak those secrets and make every user share the same identity.

The clean path is to build a fresh rootfs from the public recipes:

```text
https://github.com/hmhmdcy/realme-x2-pro-pmaports
samurai/README.md
```

The device config intentionally uses `kernel=none` and
`flash_method=none`: the result is an offline rootfs tree, not a
one-click phone image.  Boot, kernel, DTB and modules are supplied by
this repository.

## Build outline

On a Linux x86_64 or ARM64 host with an ext4 work directory:

```sh
git clone --branch stable \
  https://github.com/hmhmdcy/realme-x2-pro-pmaports.git
cd realme-x2-pro-pmaports
python3 samurai/bootstrap.py --work "$HOME/samurai-build" \
  --build --lax --jobs 4
```

Then follow `samurai/README.md` to create the offline root directory,
run `finalize-rootfs.py`, provide your own firmware/calibration inputs
and run `check-rootfs.py`.  Do not copy a maintainer's live `/home`,
`/root`, SSH host keys or NetworkManager profiles.

## Pairing with this release

The release assets are:

| Asset | Purpose |
| --- | --- |
| `boot-eud-production-off.img` | EDK2/UEFI boot carrier |
| `logdump-touch-gpi.img` | FAT containing kernel `Image` and DTB |
| `Image-touch-gpi` | kernel image for inspection/rebuild comparison |
| `modules-7.3.1-rmx1931-samurai-v731-usbwake-otg.tar.gz` | matching 772-module tree |

The module archive is not embedded in the FAT.  Before booting the new
kernel, install it into the rootfs:

```sh
sha256sum modules-7.3.1-rmx1931-samurai-v731-usbwake-otg.tar.gz
tar -xzf modules-7.3.1-rmx1931-samurai-v731-usbwake-otg.tar.gz \
  -C /lib/modules
depmod -a 7.3.1-rmx1931-samurai-v731-usbwake-otg
```

The archive's leading directory must equal `uname -r` after boot:

```text
7.3.1-rmx1931-samurai-v731-usbwake-otg
```

If the rootfs was previously used with another kernel, keep the old
module directory until the new boot is verified.  Do not overwrite or
rename module directories to make a mismatched kernel appear to work.

## What is verified

- The module archive has SHA-256
  `5045c16b46928bc6ff9fbeb0418a21e34c12356954694665634c587006e19a02`.
- Its 772 `.ko` files all report the exact release vermagic.
- Kernel `#8` passed ten warm reboots with touch present and zero GPI
  allocation errors.

What is not verified:

- a clean rootfs built from scratch on a second device;
- external-power-removed cold boot;
- 6/12 GiB and 64/128/256 GB SKUs;
- suspend/deep sleep and physical OTG host acceptance.

Do not describe a successful rootfs build as hardware acceptance.

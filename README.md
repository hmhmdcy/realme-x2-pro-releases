# Realme X2 Pro system releases

User-facing boot, kernel, DTB and recovery releases for the Realme
X2 Pro (RMX1931 / RMX1931CN, codename `samurai`).

This repository does not contain a rootfs image and does not distribute
vendor firmware, calibration, NV, persist or userdata.  A complete
installation still needs a separately prepared rootfs.

## Current release

`v2026.11.14-kernel8`

- kernel release: `7.3.1-rmx1931-samurai-v731-usbwake-otg`
- kernel build: `#8 Sat Nov 14 09:46:41 CST 2026`
- kernel Image:
  `29c8d27c64b9f3bb11bbf6b94bcd211e88aa3ad4a8d31955b37b54d622d8a739`
- kernel FAT (`logdump`):
  `125436109e7bb950bf608610ffc3dca656638764e695f52eda843eaf16d70dbb`
- boot carrier:
  `4520915183bbdf91bf606c1f2c711097a7a686c5e4666298e8bd1665a44036f1`
- DTB: `9ca1d2f9b170ebc4913d8dd0ea16442bef0556b76f9d18b3d0393870d1167162`

The boot carrier and DTB are unchanged from the preceding deployment.
The release fixes the S3706 touch probe failure by making the GENI
I2C/GPI DMA failure recoverable.  Ten actual warm reboots passed with
new boot IDs and zero `EV ALLOCATE` / `alloc_ev_chan` /
`Failed to get rx DMA` errors.

Canonical downloads:

```text
https://github.com/hmhmdcy/realme-x2-pro-releases/releases/latest/download/
```

GitHub-blocked mirror:

```text
https://ghfast.top/https://github.com/hmhmdcy/realme-x2-pro-releases/releases/latest/download/
```

The mirror only changes transport.  Always verify `SHA256SUMS`; the
release hashes in this repository are the trust boundary.

## Documents

- [INSTALL.md](INSTALL.md) - update an existing install or flash
  boot/logdump for a new install
- [MIGRATION.md](MIGRATION.md) - migrate an already-flashed device
- [RECOVERY.md](RECOVERY.md) - rollback pair and recovery boundaries
- [COMPATIBILITY.md](COMPATIBILITY.md) - tested and untested hardware
- [SUPPORT.md](SUPPORT.md) - read-only support information
- [SECURITY.md](SECURITY.md) - clean-image and secret-handling rules
- [samurai-identify.sh](samurai-identify.sh) - collect a support bundle
- [RELEASING.md](RELEASING.md) - maintainer release checklist

## Package updates

Userspace packages are published separately at:

```text
https://github.com/hmhmdcy/realme-x2-pro-apk
```

The APK repository does not update the kernel, boot carrier or DTB.
Those are system releases in this repository.

## Source

- integration/docs/patches: `hmhmdcy/realme-x2-pro-edk2`
- kernel: `hmhmdcy/realme-x2-pro-linux`
- package recipes: `hmhmdcy/realme-x2-pro-pmaports`

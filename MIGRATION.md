# Migrating an already-flashed device

People who flashed an earlier project build should not be told to
re-flash everything blindly.  First identify what they are running.

## 1. Collect read-only state

```sh
sh samurai-identify.sh > samurai-support.txt
```

Check:

- kernel release and build number;
- boot and logdump hashes;
- installed `samurai-*`, `usb-signaller` and `unudhcpd` versions;
- whether `Synaptics S3706A` is present.

## 2. Kernel update

If the device is already on the project's EDK2 boot chain and only the
kernel is old, update only `logdump`:

```sh
sh flash-kernel-linux.sh \
  --kernel-fat logdump-touch-gpi.img \
  --sha256 125436109e7bb950bf608610ffc3dca656638764e695f52eda843eaf16d70dbb
```

Do not flash `boot` if the existing boot carrier is working.  The
kernel #8 release keeps the same boot and DTB bytes.

## 3. Userspace packages

Install the public keys from `hmhmdcy/realme-x2-pro-apk` and use
explicit versions.  Do not run an unbounded `apk upgrade` on a pinned
daily-use device; official edge repositories may pull hundreds of
unrelated updates.

## 4. Personal data

If the earlier image was a copy of the maintainer's live system, treat
its SSH host keys, Wi-Fi credentials and user data as exposed.  Rebuild
from a clean rootfs; see [SECURITY.md](SECURITY.md).

## 5. Report back

Attach `samurai-support.txt`, the exact release tag and the rollback
state.  Do not attach userdata, calibration, NV or private keys.

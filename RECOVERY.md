# Recovery and rollback

## Current rollback pair

The preceding deployed state was:

```text
logdump: 98addba8b234936ab19802d62b5b60e0f9abf13a6453efbd14b79f52318ad4c0
boot:    4520915183bbdf91bf606c1f2c711097a7a686c5e4666298e8bd1665a44036f1
```

The boot carrier was not changed by the kernel #8 update.  A rollback
of the kernel only needs the previous `logdump` image:

```text
E:/edk2-samurai-out/standard-arm64-v731/otg-20261113-vbus-reg-r3/logdump-vbus-reg.img
```

If that file is not available, use any previously verified logdump
backup whose boot ID and kernel release match the intended rollback.

## Linux-side rollback

```sh
sh flash-kernel-linux.sh \
  --kernel-fat logdump-vbus-reg.img \
  --sha256 98addba8b234936ab19802d62b5b60e0f9abf13a6453efbd14b79f52318ad4c0
```

Then verify and reboot.  Do not use `--allow-untrusted` or a package
upgrade as a kernel rollback.

## Fastboot rollback

Only if the device enumerates in fastboot:

```sh
fastboot flash logdump logdump-vbus-reg.img
fastboot reboot
```

If fastboot is unavailable, use the EDL/9008 path and the factory
partition backup.  Do not guess partition numbers or write GPT, NV or
calibration images.

## Boot failure policy

- Preserve the failing boot ID and `dmesg` before another flash if the
  device still responds.
- If the boot guard starts a rollback, record the log before retrying.
- Do not combine a kernel rollback with a package upgrade or a DTB
  change in the same window.

# Compatibility

## Tested baseline

- Device: Realme X2 Pro, RMX1931 / RMX1931CN, `samurai`
- SoC: SM8150-AC
- RAM: 8 GiB project unit
- Storage: current project unit only
- Boot chain: EDK2/UEFI + external Linux kernel in the `logdump` FAT
- Kernel: `7.3.1-rmx1931-samurai-v731-usbwake-otg` build `#8`
- Module release must equal `uname -r`

## Verified in this release

- touch device present after ten actual warm reboots;
- no `EV ALLOCATE` / `alloc_ev_chan` / `Failed to get rx DMA` errors;
- Wi-Fi SSH and Plasma/KWin remained available during the soak;
- boot carrier and DTB unchanged.

## Not verified

- external-power-removed cold boot on this exact candidate;
- 6 GiB and 12 GiB RAM SKUs;
- 64 GB UFS 2.1 and 128/256 GB UFS 3.0 SKUs;
- suspend, deep sleep and USB host-resume;
- physical OTG dock/adapter acceptance;
- long-term stability, thermal soak, edge/orientation/multi-touch
  after sleep;
- real SIM, NFC tag, fingerprint, high-voltage charging and camera
  quality acceptance.

Do not claim a SKU or feature is supported because a driver registers
or a package installs.

## Package compatibility

The APK repository at `hmhmdcy/realme-x2-pro-apk` is a userspace
channel.  It does not update the kernel/boot/DTB.  A package release
must state which system release it was tested with.

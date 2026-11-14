# Releasing system boot/kernel assets

1. Build and test the kernel and boot carrier on real hardware.
2. Record kernel release, build number, Image hash, boot hash, logdump
   hash and DTB hash.
3. Verify the partition images:

   ```sh
   sha256sum boot.img logdump.img Image
   ```

4. Update `manifest.json` with the tested warm/cold boot scope and the
   exact APK repository index hash.
5. Create a new release tag such as `vYYYY.MM.DD-kernelN` and attach:
   `boot-*.img`, `logdump-*.img`, `Image`, `manifest.json`,
   `SHA256SUMS`, `flash-kernel-linux.sh`, `flash-pair-linux.sh` and
   `samurai-identify.sh`.
6. Do not attach a rootfs, userdata, calibration, NV or persist image
   unless it has been built from a clean generic source and audited.
7. Test a range download through both the canonical GitHub URL and the
   `ghfast.top` mirror, then test one real update on a non-daily device.

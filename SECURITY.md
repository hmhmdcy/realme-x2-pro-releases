# Security and privacy

System images and rootfs archives can accidentally contain personal or
device-unique data.  Before sharing an image with another person:

- do not include `/home`, `/root`, userdata, logs or browser profiles;
- remove `/etc/ssh/ssh_host_*` and any user `authorized_keys`;
- remove Wi-Fi/NetworkManager connection profiles and stored passwords;
- remove Bluetooth pairings and per-device calibration;
- do not copy NV, persist, modem configuration, sensor calibration or
  camera tuning data;
- generate fresh machine-id and host keys on first boot;
- verify the published SHA-256 before flashing.

If a live image has already been shared, assume its SSH host keys,
Wi-Fi credentials and other secrets are compromised.  Rotate them and
rebuild from a clean rootfs instead of trying to delete files from the
already distributed copy.

The release assets in this repository contain boot/kernel images only,
not a rootfs or userdata image.  Do not attach a rootfs to a release
unless it has been built from a clean, generic source and audited for
personal data.

Never commit private signing keys, SSH private keys or vendor
calibration blobs to GitHub.

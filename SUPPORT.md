# Support information

Run the read-only helper:

```sh
sh samurai-identify.sh > samurai-support.txt
```

Attach `samurai-support.txt` to a report.  It contains:

- kernel release/build;
- boot ID;
- boot and logdump hashes;
- installed `samurai-*`, `usb-signaller` and `unudhcpd` versions;
- whether the touch input device is present.

Do not attach:

- SSH private keys or host keys;
- Wi-Fi profiles/passwords;
- `/home`, userdata or full disk images;
- calibration, NV or persist dumps;
- vendor firmware blobs.

State the exact release tag and whether the problem also occurs after a
known-good rollback.

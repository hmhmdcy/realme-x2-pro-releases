# Download mirrors

Canonical release asset base:

```text
https://github.com/hmhmdcy/realme-x2-pro-releases/releases/latest/download/
```

GitHub-blocked mirror tested on 2026-11-14:

```text
https://ghfast.top/https://github.com/hmhmdcy/realme-x2-pro-releases/releases/latest/download/
```

Example:

```sh
curl -fL \
  "https://ghfast.top/https://github.com/hmhmdcy/realme-x2-pro-releases/releases/latest/download/logdump-touch-gpi.img" \
  -o logdump-touch-gpi.img
sha256sum logdump-touch-gpi.img
```

The mirror is only a transport path.  It must serve byte-identical
assets; the `SHA256SUMS` and manifest hashes remain the authority.

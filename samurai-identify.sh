#!/usr/bin/env sh
set -eu

printf 'model: '
if [ -r /proc/device-tree/model ]; then
	tr -d '\000' < /proc/device-tree/model
	printf '\n'
else
	printf 'unknown\n'
fi

printf 'kernel: '
uname -a
printf 'boot_id: '
cat /proc/sys/kernel/random/boot_id
printf 'tainted: '
cat /proc/sys/kernel/tainted 2>/dev/null || echo unknown

for part in boot logdump; do
	if [ -b "/dev/disk/by-partlabel/$part" ]; then
		printf '%s_size: ' "$part"
		blockdev --getsize64 "/dev/disk/by-partlabel/$part"
		printf '%s_sha256: ' "$part"
		sha256sum "/dev/disk/by-partlabel/$part" | cut -d' ' -f1
	else
		printf '%s: missing\n' "$part"
	fi
done

printf 'touch: '
if grep -q 'Synaptics S3706A' /proc/bus/input/devices; then
	echo present
else
	echo missing
fi

printf 'packages:\n'
apk info -v 2>/dev/null |
	grep -E '^(samurai|usb-signaller|unudhcpd|device-realme)' |
	sort || true

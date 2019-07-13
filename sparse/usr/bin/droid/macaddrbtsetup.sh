#!/bin/bash

echo "macaddr: Setting bt MAC address"

# Ensure /persist/bluetooth/.bt_nv.bin exists
/system/bin/btnvtool -O

# Convert '1.2a.3b.4c.5d.6d' to '6d:5d:4c:3b:2a:01'
awk_program='                                                \
/--board-address/ {                                          \
    split($2, mac, ".");                                     \
    for (i = 1; i <= 6; i++) {                               \
        if (length(mac[i]) == 1) {                           \
            mac[i] = "0" mac[i];                             \
        }                                                    \
    }                                                        \
    printf("%s:%s:%s:%s:%s:%s\n",                            \
           mac[6], mac[5], mac[4], mac[3], mac[2], mac[1]);  \
}'

mac=$(/system/bin/btnvtool -p 2>&1 | awk "${awk_program}")

if [ ! -f "/data/misc/bluetooth/bluetooth_bdaddr" ]; then
    echo "File not found!"
    mkdir -p "/data/misc/bluetooth/"
	chmod 0755 "/data/misc/bluetooth/"
	echo "$mac" > "/data/misc/bluetooth/bluetooth_bdaddr"
fi

if [ -e "/data/misc/bluetooth/bluetooth_bdaddr" ]; then
	mkdir -p "/var/lib/bluetooth"
	chmod 0755 "/var/lib/bluetooth"
	addr="$(cat /data/misc/bluetooth/bluetooth_bdaddr)"
	if [ -e "/var/lib/bluetooth/board-address" ]; then
		if [ "$addr" != "$(cat /var/lib/bluetooth/board-address)" ]; then
			echo "macaddr: Updating bt MAC address"
			echo "$addr" > /var/lib/bluetooth/board-address
			echo "macaddr: Done"
		fi
	else
		echo "macaddr: Setting bt MAC address"
		echo "$addr" > /var/lib/bluetooth/board-address
		echo "macaddr: Done"
	fi
fi

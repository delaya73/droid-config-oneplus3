#!/bin/bash
echo "macaddr: Setting bt MAC address"

mac=$(cat /sys/devices/soc/7570000.uart/tty/ttyHS0/hci0/address)

if [ ! -f "/data/misc/bluetooth/bluetooth_bdaddr" ]; then
    echo "File not found!"
    mkdir -p "/data/misc/bluetooth/"
	chmod 0755 "/data/misc/bluetooth/"
	echo $mac > "/data/misc/bluetooth/bluetooth_bdaddr"
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

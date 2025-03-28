#!/bin/bash

echo "====================== FC LUN Mapping ======================"

for dev in $(ls /sys/block | grep '^sd[a-z]$'); do
  echo "Device: /dev/$dev"

  dev_path="/sys/block/$dev/device"

  # Extract SCSI address
  scsi_address=$(basename $(readlink -f "$dev_path"))
  [[ "$scsi_address" =~ ^([0-9]+):([0-9]+):([0-9]+):([0-9]+)$ ]] || {
    echo "Skipping non-SCSI device"
    continue
  }

  host_id="${BASH_REMATCH[1]}"
  channel="${BASH_REMATCH[2]}"
  target="${BASH_REMATCH[3]}"
  lun="${BASH_REMATCH[4]}"

  echo "SCSI Address: $scsi_address"
  echo "Host: host$host_id"
  echo "Channel: $channel"
  echo "Target: $target"
  echo "LUN ID: $lun"

  fc_host_path="/sys/class/fc_host/host$host_id"
  if [[ -d "$fc_host_path" ]]; then
    wwpn=$(cat "$fc_host_path/port_name" 2>/dev/null)
    port_num=$(cat "$fc_host_path/port_number" 2>/dev/null)

    echo "Local WWPN: $wwpn"
    echo "Port Number: $port_num"
  else
    echo "FC HBA info not available for host$host_id"
  fi

  # WWID
  wwid=$(sg_inq --page=0x83 /dev/$dev 2>/dev/null | grep -Eo '0x[0-9a-f]{32,}')
  echo "WWID (NAA): $wwid"
  echo ""
done

echo "============================================================"


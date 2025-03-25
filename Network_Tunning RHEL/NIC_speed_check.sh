for iface in $(ls /sys/class/net/ | grep -v lo); do
  echo -n "$iface: "
  ethtool $iface 2>/dev/null | grep -i speed || echo "N/A"
done

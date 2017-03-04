#!/bin/sh

#
# Configure ipsec.conf and start IPsec daemon
#

P_IP=${P_IP:-10.1.0.1}

echo "Private IP: $P_IP"

sed -i -e 's/__P_IP__/'${P_IP}'/g' /etc/ipsec.conf

ipsec start

ip ad ad dev lo $P_IP/32

until false
do
  watch -n 1 ipsec statusall
done

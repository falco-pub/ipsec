#!/bin/sh

#
# Configure ipsec.conf and start IPsec daemon
#

HOSTNAME=${HOSTNAME:-core1}
P_IP=${P_IP:-10.1.0.1}

echo "Hostname: $HOSTNAME"
echo "Private IP: $P_IP"

sed -i -e 's/__HOSTNAME__/'${HOSTNAME}'/g' /etc/ipsec.conf
sed -i -e 's/__P_IP__/'${P_IP}'/g' /etc/ipsec.conf

echo ": RSA ${HOSTNAME}.key" > /etc/ipsec.secrets

ipsec start

ip ad ad dev lo $P_IP/32

until false
do
  watch -n 1 ipsec statusall
done

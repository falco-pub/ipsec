#!/bin/sh

#
# Print a brand new CSR
# 

_dn="/C=FR/ST= /O=Falco/OU=Falco IPSEC/CN=${HOSTNAME}"
openssl req -new -nodes -out /mnt/${HOSTNAME}.csr -keyout /mnt/${HOSTNAME}.key -subj "$_dn"

echo "Certificate request DN: $_dn"

cat /mnt/${HOSTNAME}.csr

echo

cat << EOF
# Then copy/paste the CSR to the CA server
# Sign the CSR on the CA server
#   (Configure in openssl.cnf, section 'alt_names':
#      [ ca ]
#      default_ca      = CA_default
#      [ CA_default ]
#      x509_extensions = usr_cert
#      [ usr_cert ]
#      keyUsage = nonRepudiation, digitalSignature, keyEncipherment 
#      subjectAltName=@alt_names 
#      [alt_names]
#      DNS.1 = xxxx (host id)
#    Then openssl ca -out xxxx.crt -infiles xxxx.csr)
#  Copy the CRT and the KEY to the docker repository
#  Rebuild image with --build-arg HOSTNAME=xxxx
#    docker build --build-arg HOSTNAME=xxxx -t ipsec-xxxx
EOF

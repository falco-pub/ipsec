FROM alpine:latest

VOLUME ["/mnt", "/etc/ipsec.d"]

# Install strongswan
RUN apk update
RUN apk add strongswan
RUN apk add openssl

# Populates /etc/ipsec.* files
COPY etc/ipsec.conf /etc/

COPY *.sh /

# To generate a private key and print the CSR
# takes env: HOSTNAME=... ( docker run --env HOSTNAME= )
# CMD ["/csr.sh"]

# To start ipsec daemons (needs --privileged --net=host)
# takes env: P_IP=... ( docker run --env P_IP= )
CMD ["/ipsec.sh"]

FROM alpine:latest

VOLUME ["/mnt", "/etc/ipsec.d"]

# Install strongswan
RUN apk update
RUN apk add strongswan
RUN apk add openssl

# Takes local hostname as optional arguments
ARG HOSTNAME
ENV HOSTNAME ${HOSTNAME:-xxxx}

# Populates /etc/ipsec.* files
COPY etc/ipsec.conf /etc/
RUN echo ": RSA ${HOSTNAME}.key" > /etc/ipsec.secrets

# Configures local hostname
RUN sed -i -e 's/__HOSTNAME__/'${HOSTNAME}'/g' /etc/ipsec.conf

COPY *.sh /

# To generate a private key and print the CSR
# takes env: HOSTNAME=... ( docker run --env HOSTNAME= )
# CMD ["/csr.sh"]

# To start ipsec daemons (needs --privileged --net=host)
# takes env: P_IP=... ( docker run --env P_IP= )
CMD ["/ipsec.sh"]

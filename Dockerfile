FROM alpine:latest

VOLUME ["/mnt"]

# Install strongswan
RUN apk update
RUN apk add strongswan
RUN apk add openssl

# Takes private hostname and private IP address as optional arguments
ARG HOSTNAME
ENV HOSTNAME ${HOSTNAME:-xxxx}
#ARG P_IP
#ENV P_IP ${P_IP:-10.1.0.1}

# Populates /etc/ipsec.* files
COPY etc/ipsec.conf /etc/
RUN echo ": RSA ${HOSTNAME}.key" > /etc/ipsec.secrets
COPY etc/ipsec.d/private/${HOSTNAME}.key /etc/ipsec.d/private/
COPY etc/ipsec.d/certs/* /etc/ipsec.d/certs/
COPY etc/ipsec.d/cacerts/* /etc/ipsec.d/cacerts/
COPY *.sh /

# Configures private IP address
RUN sed -i -e 's/__HOSTNAME__/'${HOSTNAME}'/g' /etc/ipsec.conf

# To generate a private key and print the CSR
# takes env: HOSTNAME=... ( docker run --env HOSTNAME= )
# CMD ["/csr.sh"]

# To start ipsec daemons (needs --privileged --net=host)
# takes env: P_IP=... ( docker run --env P_IP= )
CMD ["/ipsec.sh"]

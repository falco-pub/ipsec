# ipsec
Simple IPsec container (start daemon, show status, generate CSR)

```shell
 # build ipsec image with id=core1 :
 docker build -t ipsec https://github.com/falco-pub/ipsec.git
 
 # start ipsec with id=core1 
 docker run -e HOSTNAME=core1 -e P_IP=10.1.0.1 --privileged --net=host -v /mnt/alpine/ipsec/etc/ipsec.d:/etc/ipsec.d -d ipsec
 docker run -e HOSTNAME=core2 -e P_IP=10.1.0.2 --privileged --net=host -v /mnt/alpine/ipsec/etc/ipsec.d:/etc/ipsec.d -d ipsec
 ...
 
 docker attach ...

 # make a CSR
 docker run -e HOSTNAME="foo" ipsec-core1 /csr.sh
 docker ps -l
 docker inspect --format='{{.Mounts}}' XXXX | |cut -d' ' -f 9
 
 # copy the CSR on the CA server
 # sign on the CA server (change alt_names:DNS.1 + openssl ca -out foo.crt -infiles foo.csr)
 # copy the CRT and the KEY on the docker repository
 # rebuild with --build-arg HOSTNAME=foo
 # docker build --build-arg HOSTNAME=core2 -t ipsec-core2 
``` 





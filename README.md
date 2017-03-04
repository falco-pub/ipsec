# ipsec
Simple IPsec container (start daemon, show status, generate CSR)

```shell
 # build ipsec image with id=core1 :
 docker build -t ipsec-core1 /mnt/alpine/ipsec/
 docker build --build-arg HOSTNAME=core1 -t ipsec-core1 /mnt/alpine/ipsec/
 
 # start ipsec with id=core1 
 docker run --privileged --net=host -d ipsec-core1
 # or 
 docker run -e P_IP=10.1.0.1 --privileged --net=host -d ipsec-core1
 
 # make a CSR
 docker run -e HOSTNAME="foo" ipsec-core1 /csr.sh
 docker ps -l
 docker inspect --format='{{.Mounts}}' XXXX | |cut -d' ' -f 2
 
 # copy the CSR on the CA server
 # sign on the CA server (change alt_names:DNS.1 + openssl ca -out foo.crt -infiles foo.csr)
 # copy the CRT and the KEY on the docker repository
 # rebuild with --build-arg HOSTNAME=foo
 # docker build --build-arg HOSTNAME=core2 -t ipsec-core2 
``` 





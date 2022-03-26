# dns2ip
Simple bash script to resolv a list of domain names from a file. The file must contain a domain name for each line.

## Usage

```
./dns2ip.sh domanis.txt
```

output

```
domain1 IP
domain2 IP1,IP2
domain3 IP
domain4       # <-- timeout or no ip address
```

#!/bin/bash

nmap="$1"
dnsx="$2"

# ./vhost-kit.sh nmap.xml dnsx-output.txt > vhosts.txt
# cat vhosts.txt | httpx
# axiom-scan vhosts.txt -m httpx -o http.txt

tmp="$RANDOM"
mkdir -p "$tmp"
cat "$dnsx" | tr -d '[]' > "$tmp/dns.txt"
./bin/parse_dnsprobe.rb "$tmp/dns.txt"
python2 ./bin/ports.py "$nmap" > "$tmp/ports.txt"
./bin/ips_vhosts.rb "$tmp/ports.txt"
rm -rf "$tmp"

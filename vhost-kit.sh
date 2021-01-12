#!/bin/bash

nmap="$1"
dnsx="$2"

tmp="$RANDOM"
mkdir -p "$tmp"
cat "$dnsx" | tr -d '[]' > "$tmp/dns.txt"
./bin/parse_dnsprobe.rb "$tmp/dns.txt"
python2 ./bin/ports.py "$nmap" > "$tmp/ports.txt"
./bin/ips_vhosts.rb "$tmp/ports.txt"
rm -rf "$tmp"

#!/usr/bin/env ruby

require 'json'

index = "index.json"
dnsprobe = ARGV[0]

data = {}

if File.exist? index
  open(index, "r") do |f|
    data = JSON.parse(f.read())
  end
end

dns = File.open(dnsprobe).read().split("\n")

dns.each do |line|
  domain = line.split(" ")[0]
  ip = line.split(" ")[1]
  
  if data.has_key? ip
    data[ip].push(domain)
  else
    data[ip] = [domain]
  end
end

open(index, 'w') do |f|
  f.write(JSON.pretty_generate(data))
end


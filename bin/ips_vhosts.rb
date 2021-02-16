#!/usr/bin/env ruby

require 'json'

dns = JSON.parse(File.open("index.json", 'r').read())
svc = File.open(ARGV[0]).read().split("\n")
add_svc = []
svc.each do |svc|
  puts svc
  ip = svc.split(":")[0]
  port = svc.split(":")[1]

  if dns.has_key? ip

  dns[ip].each do |domain|
    puts "#{domain}:#{port}"
  end
  end
end

puts add_svc

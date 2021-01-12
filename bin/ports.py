#!/usr/bin/env python


## $ ports.py nmap.xml
## 8.8.8.8:80
## 8.8.8.8:443
## 8.8.8.8:3305

#install requirements: pip install python-libnmap
#uses python 2
#usage is something like ./python nmapParse.py scan.xml

from libnmap.parser import NmapParser
import sys
def printsortedlistnewlines(list):
	output = ""
        list = sorted(set(list))
        for l in list:
                output += str(l) + "\n"
        print output[:-1]


nmap_report = NmapParser.parse_fromfile(sys.argv[1])
#print "Nmap scan summary: {0}".format(nmap_report.summary)

openports = []
opentcp = []
openudp = []
openhosts = []

#trying to get
#PORT	PROTOCOL	SERVICE	VERSION
#443	tcp	ssl/http
openportprotoserviceversion = []
servicePort = []
servicePortNoBanner = []
servicePortCount = []

for h in nmap_report.hosts:
        for s in h.services:
                if s.state != "open|filtered":
                        openports.append(s.port)
                        openhosts.append(h.ipv4)
                        if s.protocol == "tcp":
                                opentcp.append(s.port)
                        else:
                                openudp.append(s.port)

                        openportprotoserviceversion.append(str(h.ipv4) + ":" + str(s.port))
                        #for uniqueService in servicePort:
                        #        rcommmaindex = uniqueService.rfind(",")
                        #        if (uniqueService[:rcommmaindex] ==  str(s.port) + " - " + str(s.protocol).upper() + " - " + str(s.service) + "," +  str(s.banner)):
                        #                servicePortCount.append(uniqueService[:rcommmaindex] + " " + str(int(uniqueService[rcommmaindex+2:])+1))

printsortedlistnewlines(openportprotoserviceversion)

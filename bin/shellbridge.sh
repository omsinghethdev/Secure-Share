#!/usr/bin/env bash
#current version tested on macOS en0 interface
ip_addr=$(ifconfig en0 | grep "inet" | grep "netmask" | awk '{print $2}')
networkPrefix=$(echo "${ip_addr}" | awk -F "." '{print $1"."$2"."$3}')

ping_log="/Users/omkumarsingh/Desktop/LinuxProjects/ShellBridge/temp/ping-result.txt"

> "${ping_log}"
count=1
while [[ ${count} -le 254 ]]; do
    current_ip="${networkPrefix}.${count}"
(
    ping -c 1 "${current_ip}" >> "${ping_log}" 2>&1

) &  
       (( count=count+1 ))
done






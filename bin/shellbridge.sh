#!/usr/bin/env bash
#current version tested on macOS en0 interface
ip_addr=$(ifconfig en0 | grep "inet" | grep "netmask" | awk '{print $2}')
networkPrefix=$(echo "${ip_addr}" | awk -F "." '{print $1"."$2"."$3}')

temp_file="/temp/active.txt"
> "$temp_file"
count=1
while [[ ${count} -le 25 ]]; do
    current_ip="${networkPrefix}.${count}"
(
    ping -c 1 "${current_ip}" > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "$current_ip" >> "$temp_file"
    fi
) &  
       (( count=count+1 ))
done

wait

echo "Acitve devices found:"
cat "$temp_file"


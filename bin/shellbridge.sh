#!/usr/bin/env bash
#current version tested on macOS en0 interface
# 1. Detect local Network
ip_addr=$(ifconfig en0 | grep "inet" | grep "netmask" | awk '{print $2}')
networkPrefix=$(echo "${ip_addr}" | awk -F "." '{print $1"."$2"."$3}')
# 2. Scan Network
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
wait
# 3. Filter Acitve Devices
active_devices="/Users/omkumarsingh/Desktop/LinuxProjects/ShellBridge/temp/active.txt"
> "$active_devices"
cat "${ping_log}" | grep -F '64 bytes from' >> "${active_devices}"

active_device_ip=($(cat "${active_devices}" | awk '{print $4 }'| sed 's/:$//') )
# 4. Display and Select Device
index=1

for ip in "${active_device_ip[@]}"; do
    echo "${index}: ${ip}"
    ((index=index+1))
done

read -p "Select device number:" choice

selected_ip="${active_device_ip[$((choice - 1))]}"
echo "Selected device: ${selected_ip}"
read -p "Enter remote user name:" remote_user
# 5. SSH key Setup
ssh_private_key="/Users/omkumarsingh/.ssh/id_ed25519"
ssh_pub_key="/Users/omkumarsingh/.ssh/id_ed25.pub519"
if [[ -f  "${ssh_private_key}" && -f "${ssh_pub_key}" ]]; then
    echo "Ssh Key pair already exits."
else 
    echo "Generating keys..."
    ssh-keygen -t ed25519 -f "${ssh_private_key}"
fi
    




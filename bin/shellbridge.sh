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
if [[ ${#active_device_ip[@]} -eq 0 ]]; then
    echo "No active devices found."
    exit 1
fi
# 4. Display and Select Device
index=1

for ip in "${active_device_ip[@]}"; do
    echo "${index}: ${ip}"
    ((index=index+1))
done

read -p "Select device number:" choice
if [[ -z "${active_device_ip[$((choice - 1))]}" ]]; then
    echo "Invalid selection."
    exit 1
fi

selected_ip="${active_device_ip[$((choice - 1))]}"
echo "Selected device: ${selected_ip}"
read -p "Enter remote user name:" remote_user
# 5. SSH Authentication Setup
ssh_private_key="/Users/omkumarsingh/.ssh/id_ed25519"
ssh_pub_key="/Users/omkumarsingh/.ssh/id_ed25519.pub"
if [[ -f  "${ssh_private_key}" && -f "${ssh_pub_key}" ]]; then
    echo "Ssh Key pair already exits."
else 
    echo "Generating keys..."
    ssh-keygen -t ed25519 -f "${ssh_private_key}" -N ""
fi
remote_target="${remote_user}@${selected_ip}"

if ssh -o BatchMode=yes "${remote_target}" "echo connected" > /dev/null 2>&1 ; then
    echo "Passwordless SSH already works. Skipping key copy."
else
echo "Passwordless SSH not configured. Copying public key..."
    ssh-copy-id -i "${ssh_pub_key}" "${remote_target}"
fi
# verify SSH before transfer
if ssh -o BatchMode=yes "$remote_target" "echo connected" > /dev/null 2>&1; then
    echo "SSH authentication setup successful."
else
    echo "SSH authentication setup failed."
    exit 1
fi
# 6. File transfer logic
read -p "Enter file path to transfer: " file_path
read -p "Enter remote destination path: " remote_path

if [[ -f "$file_path" ]]; then

    scp "$file_path" "${remote_target}:${remote_path}"
    if [[ $? -eq 0 ]]; then
        echo "File transferred successfully."
    else
        echo "File transfer failed."
    fi
else
    echo "File does not exist."
fi



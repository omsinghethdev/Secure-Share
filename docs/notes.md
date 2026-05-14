Day1 :
- Extracted ip address from the acitve interface(en0) using ifconfig,awk and grep
- Derived network prefix for local IP for subnet scanning
- Implemented host scan over local network range.
- Switched from sequential ping to parallel background ping for faster scanning.
- Stored reachable host in /temp/active.txt.
- Learned issue with relative path while running script from bin/.
- Planned next step: device selection + SSH key-based authentication.
Day2 :
- Some devices may not resposd to ping (ICMP blocked) so they may not appear in active host result.This will be improved in the future version using ARP or port based discovery.

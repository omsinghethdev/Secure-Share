Day1 :
- Extracted ip address from the acitve interface(en0) using ifconfig,awk and grep
- Derived network prefix for local IP for subnet scanning
- Implemented host scan over local network range.
- Switched from sequential ping to parallel background ping for faster scanning.
- Stored reachable host in /temp/active.txt.
- Learned issue with relative path while running script from bin/.
- Planned next step: device selection + SSH key-based authentication.

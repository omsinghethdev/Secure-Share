# ShellBridge

ShellBridge is a Bash-based secure local network file transfer utility designed for Linux/macOS environments.

The project automatically scans the local network, detects active devices, allows the user to select a target device, configures SSH authentication, and securely transfers files using SCP.

---

## Features

- Automatic local network scanning
- Active device detection
- Device selection menu
- SSH key generation and authentication setup
- Passwordless SSH configuration using `ssh-copy-id`
- Secure file transfer using SCP
- Parallel ping scanning for faster discovery

---

## Project Workflow

```text
Scan Network
→ Detect Active Devices
→ Select Target Device
→ Configure SSH Authentication
→ Transfer File Securely
```

---

## Project Structure

```text
.
├── bin
│   └── shellbridge.sh
├── config
├── docs
│   └── notes.md
├── hosts.conf
├── logs
│   └── transfer.log
├── README.md
├── temp
│   ├── active.txt
│   └── ping-result.txt
└── tests
    └── sample.txt
```

---

## Requirements

- Bash
- OpenSSH
- macOS/Linux environment
- Devices connected to the same local network

---

## Usage

Make the script executable:

```bash
chmod +x bin/shellbridge.sh
```

Run the script:

```bash
./bin/shellbridge.sh
```

---

## Example Usage

1. Run the script
2. Scan active devices on the local network
3. Select the target device
4. Configure SSH authentication
5. Transfer files securely using SCP

---

## Technologies Used

- Bash Scripting
- SSH
- SCP
- grep
- awk
- sed

---

## Security

ShellBridge uses SSH and SCP for encrypted authentication and secure file transfer across devices connected to the same local network.

---

## Known Limitations

- Devices blocking ICMP (ping) may not appear in scan results
- Currently tested on macOS `en0` interface
- Limited validation and error handling in current version

---

## Future Improvements

- ARP-based device discovery
- GUI version using Python or Electron
- Android device support
- Multiple file transfer support
- Better logging and progress display
- Cross-platform interface detection

---

## Learning Outcomes

This project helped in understanding:

- Bash scripting
- Local network scanning
- Parallel process execution
- SSH authentication
- Secure file transfer
- Text processing using grep, awk, and sed
- Automation workflow design

---

## Author

Om Kumar Singh
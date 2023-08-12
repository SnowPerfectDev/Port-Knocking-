---
### SecurePortKnocker

The **SecurePortKnocker** script is a shell-based automated tool that implements the "port knocking" technique to enhance remote system access security. By providing a sequential list of ports as "knocks" and a target IP address, the script simulates the port knocking process, opening specific ports in a defined sequence. After the sequence is completed, the script checks for open ports on the remote system using the nmap utility. This enables a more secure access approach where necessary ports are only opened after a specific sequence of ports is "knocked," helping protect against undesired scans and enhancing network defense.

---

**Usage:**

```bash
./SecurePortKnocker.sh -p <port1> -p <port2> -p <port3> -i <IP Address>

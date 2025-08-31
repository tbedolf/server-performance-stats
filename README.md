# Server Performance Stats

A simple Bash script to analyze Linux server performance.

## Features
- CPU usage
- Memory usage
- Disk usage
- Top 5 processes by CPU
- Top 5 processes by memory
- Optional: OS version, uptime, load average, logged-in users, failed login attempts

## Requirements
- Linux system
- `sysstat` package (`mpstat` command)  
  Install with:
  ```bash
  sudo apt install sysstat    # Debian/Ubuntu
  sudo yum install sysstat    # CentOS/RHEL


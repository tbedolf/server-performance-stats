#!/bin/bash
#
# server-stats.sh - Basic server performance stats analyzer
#

echo "==========================================="
echo "      SERVER PERFORMANCE STATISTICS"
echo "==========================================="

# --- OS & Uptime Info (stretch goal) ---
echo "OS Version: $(cat /etc/*release | grep PRETTY_NAME | cut -d= -f2 | tr -d \")"
echo "Kernel Version: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "Logged in users: $(who | wc -l)"
echo "-------------------------------------------"

# --- CPU Usage ---
echo "[CPU Usage]"
mpstat 1 1 | awk '/Average:/ {printf "User: %.2f%%  System: %.2f%%  Idle: %.2f%%\n", $3, $5, $12}'
echo "-------------------------------------------"

# --- Memory Usage ---
echo "[Memory Usage]"
free -h | awk '
NR==2 {
    used=$3; free=$4; total=$2; percent=($3/$2)*100
    printf "Total: %s | Used: %s | Free: %s | Usage: %.2f%%\n", total, used, free, percent
}'
echo "-------------------------------------------"

# --- Disk Usage ---
echo "[Disk Usage]"
df -h --total | grep total | awk '{printf "Total: %s | Used: %s | Free: %s | Usage: %s\n",$2,$3,$4,$5}'
echo "-------------------------------------------"

# --- Top 5 Processes by CPU ---
echo "[Top 5 Processes by CPU Usage]"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
echo "-------------------------------------------"

# --- Top 5 Processes by Memory ---
echo "[Top 5 Processes by Memory Usage]"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
echo "-------------------------------------------"

# --- Failed login attempts (stretch goal) ---
if [ -f /var/log/auth.log ]; then
    echo "[Failed Login Attempts]"
    grep "Failed password" /var/log/auth.log | tail -n 5
    echo "-------------------------------------------"
fi

echo "Report generated on: $(date)"
echo "==========================================="


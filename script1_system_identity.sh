#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Trisha | Registration: 24BAC10012
# Course: Open Source Software | OSS NGMC Capstone
# Description: Displays a welcome screen with key system info
#              relevant to the Linux Kernel audit project.
# ============================================================

# --- Student & Project Variables ---
STUDENT_NAME="Trisha"
REG_NUMBER="24BAC10012"
SOFTWARE_CHOICE="Linux Kernel"
OS_LICENSE="GNU General Public License version 2 (GPL v2)"

# --- Gather System Information using command substitution ---
KERNEL=$(uname -r)                          # Kernel version
ARCH=$(uname -m)                            # CPU architecture
USER_NAME=$(whoami)                         # Logged-in username
HOME_DIR=$HOME                              # Home directory of current user
UPTIME=$(uptime -p)                         # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')        # Formatted date
CURRENT_TIME=$(date '+%H:%M:%S')            # Formatted time
HOSTNAME=$(hostname)                        # System hostname

# --- Get Linux distribution name from os-release file ---
# Source the file to load PRETTY_NAME and other variables
if [ -f /etc/os-release ]; then
    DISTRO=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="Unknown Linux Distribution"
fi

# --- Display Banner ---
echo "=================================================================="
echo "         OPEN SOURCE SOFTWARE — CAPSTONE PROJECT REPORT"
echo "=================================================================="
echo ""

# --- Student Details ---
echo "  Student   : $STUDENT_NAME"
echo "  Reg No.   : $REG_NUMBER"
echo "  Software  : $SOFTWARE_CHOICE"
echo ""
echo "------------------------------------------------------------------"

# --- System Identity Block ---
echo "  SYSTEM IDENTITY"
echo "------------------------------------------------------------------"
echo "  Hostname      : $HOSTNAME"
echo "  Distribution  : $DISTRO"
echo "  Kernel Version: $KERNEL"
echo "  Architecture  : $ARCH"
echo ""

# --- User Session Block ---
echo "  USER SESSION"
echo "------------------------------------------------------------------"
echo "  Logged-in User: $USER_NAME"
echo "  Home Directory: $HOME_DIR"
echo ""

# --- Time & Uptime Block ---
echo "  TIME & UPTIME"
echo "------------------------------------------------------------------"
echo "  Date          : $CURRENT_DATE"
echo "  Time          : $CURRENT_TIME"
echo "  System Uptime : $UPTIME"
echo ""

# --- License Information ---
echo "  OS LICENSE"
echo "------------------------------------------------------------------"
echo "  The Linux Kernel running on this system is licensed under:"
echo "  $OS_LICENSE"
echo ""
echo "  This means you are free to: run, study, modify, and"
echo "  distribute this software, provided all modifications"
echo "  remain under the same GPL v2 license (copyleft)."
echo ""
echo "=================================================================="
echo "  End of System Identity Report"
echo "=================================================================="

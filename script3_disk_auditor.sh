#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: Trisha | Registration: 24BAC10012
# Course: Open Source Software | OSS NGMC Capstone
# Description: Loops through important system directories and
#              reports their size, owner, and permissions.
#              Also checks Linux kernel-specific directories.
# ============================================================

# --- Header ---
echo "=================================================================="
echo "  DISK AND PERMISSION AUDITOR"
echo "  Student: Trisha | Reg: 24BAC10012"
echo "  Date: $(date '+%d %B %Y %H:%M:%S')"
echo "=================================================================="
echo ""

# --- List of standard system directories to audit ---
# These are important directories on any Linux system
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/boot" "/proc" "/sys")

echo "  STANDARD SYSTEM DIRECTORIES"
echo "------------------------------------------------------------------"
printf "  %-20s %-25s %-10s\n" "DIRECTORY" "PERMISSIONS (perm user grp)" "SIZE"
echo "------------------------------------------------------------------"

# --- for loop: Iterate over each directory in the list ---
for DIR in "${DIRS[@]}"; do

    # Check if the directory exists before trying to read it
    if [ -d "$DIR" ]; then

        # Extract permissions, owner user, and owner group using ls and awk
        # ls -ld gives: permissions links user group size date name
        # awk prints fields 1 (permissions), 3 (user), 4 (group)
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # Get human-readable directory size using du
        # 2>/dev/null suppresses permission errors for /proc and /sys
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Handle cases where size cannot be determined (e.g. /proc, /sys)
        if [ -z "$SIZE" ]; then
            SIZE="N/A"
        fi

        # Print formatted output for this directory
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS" "$SIZE"

    else
        # Directory does not exist on this system
        printf "  %-20s %s\n" "$DIR" "[DOES NOT EXIST ON THIS SYSTEM]"
    fi

done

echo ""
echo "------------------------------------------------------------------"
echo "  LINUX KERNEL-SPECIFIC DIRECTORIES"
echo "------------------------------------------------------------------"
echo "  Checking directories specific to the Linux Kernel audit..."
echo ""

# --- Array of kernel-specific directories to check ---
KERNEL_VERSION=$(uname -r)
KERNEL_DIRS=(
    "/boot"
    "/boot/grub"
    "/lib/modules/$KERNEL_VERSION"
    "/usr/src/linux-headers-$KERNEL_VERSION"
    "/proc/sys/kernel"
)

# --- for loop over kernel-specific directories ---
for KDIR in "${KERNEL_DIRS[@]}"; do

    if [ -d "$KDIR" ]; then
        # Get permissions string
        KPERMS=$(ls -ld "$KDIR" | awk '{print $1, $3, $4}')
        KSIZE=$(du -sh "$KDIR" 2>/dev/null | cut -f1)

        # Default to N/A if size is unavailable
        [ -z "$KSIZE" ] && KSIZE="N/A"

        echo "  [FOUND]   $KDIR"
        echo "            Permissions : $KPERMS"
        echo "            Size        : $KSIZE"
    else
        echo "  [MISSING] $KDIR (not present on this system)"
    fi
    echo ""

done

echo "------------------------------------------------------------------"
echo "  WHY PERMISSIONS MATTER FOR THE LINUX KERNEL"
echo "------------------------------------------------------------------"
echo "  In Linux, every file and directory has an owner, a group,"
echo "  and a permission triplet (read/write/execute) for owner,"
echo "  group, and others. Critical directories like /boot (which"
echo "  contains the kernel image) are owned by root and restricted"
echo "  to prevent unauthorised modification — a core security"
echo "  principle enabled by Linux's open, auditable design."
echo ""
echo "=================================================================="
echo "  End of Disk and Permission Auditor"
echo "=================================================================="

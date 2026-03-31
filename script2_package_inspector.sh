#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Trisha | Registration: 24BAC10012
# Course: Open Source Software | OSS NGMC Capstone
# Description: Checks if a FOSS package is installed, shows
#              version/license info, and prints a philosophy
#              note about the package using a case statement.
# ============================================================

# --- Target Package ---
# For Linux Kernel audit, we inspect the linux-image package
PACKAGE="linux-image-$(uname -r)"
PACKAGE_SHORT="linux-image"     # Short name for case statement matching

# --- Header ---
echo "=================================================================="
echo "  FOSS PACKAGE INSPECTOR"
echo "  Student: Trisha | Reg: 24BAC10012"
echo "=================================================================="
echo ""

# --- Check if running on a dpkg-based system (Ubuntu/Debian) ---
if ! command -v dpkg &>/dev/null; then
    echo "ERROR: This script requires a dpkg-based system (Ubuntu/Debian)."
    exit 1
fi

# --- if-then-else: Check whether the Linux kernel package is installed ---
echo "  Checking package: $PACKAGE"
echo "------------------------------------------------------------------"

if dpkg -l "$PACKAGE" &>/dev/null; then
    # Package IS installed — display details
    echo "  STATUS: $PACKAGE is INSTALLED on this system."
    echo ""

    # Extract key fields from dpkg output using grep and awk
    echo "  PACKAGE DETAILS:"
    dpkg -l "$PACKAGE" | grep "^ii" | awk '{
        print "  Package   : " $2
        print "  Version   : " $3
        print "  Arch      : " $4
    }'

    # Also display kernel info from uname for additional context
    echo ""
    echo "  KERNEL INFO (from uname):"
    echo "  Kernel Release  : $(uname -r)"
    echo "  Kernel Version  : $(uname -v)"
    echo "  Operating System: $(uname -o)"

else
    # Package is NOT installed — inform and suggest install command
    echo "  STATUS: $PACKAGE is NOT installed."
    echo ""
    echo "  To install the current kernel package, run:"
    echo "  sudo apt-get install linux-image-\$(uname -r)"
fi

echo ""
echo "------------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------------"

# --- case statement: Print philosophy note based on package name ---
# Matches the short package name to identify the software
case $PACKAGE_SHORT in
    linux-image)
        echo "  Linux Kernel: The foundation that Linus Torvalds built"
        echo "  as a hobby in 1991. Today it powers 96% of the world's"
        echo "  servers, every Android phone, and all 500 of the world's"
        echo "  fastest supercomputers. Licensed under GPL v2 — copyleft"
        echo "  ensures it remains free for all, forever."
        ;;
    apache2 | httpd)
        echo "  Apache HTTP Server: The web server that powered the early"
        echo "  internet and continues to serve ~30% of all websites today."
        echo "  Licensed under Apache 2.0 — permissive and business-friendly."
        ;;
    mysql-server | mysql)
        echo "  MySQL: The open source database at the heart of millions"
        echo "  of applications. Its dual GPL/commercial license model"
        echo "  tells a fascinating story about open source economics."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open web,"
        echo "  built by Mozilla under the MPL 2.0 license."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris who just wanted to stream"
        echo "  video on their campus network. Now plays anything, anywhere."
        ;;
    python3 | python)
        echo "  Python: A language shaped entirely by its community,"
        echo "  under the PSF license — proof that open governance works."
        ;;
    git)
        echo "  Git: The version control tool Linus built when BitKeeper"
        echo "  went proprietary. Now the foundation of all software"
        echo "  collaboration worldwide."
        ;;
    *)
        # Default case for any unrecognized package
        echo "  $PACKAGE_SHORT: An open source tool contributing to"
        echo "  the shared foundation of modern computing."
        ;;
esac

echo ""
echo "=================================================================="
echo "  End of FOSS Package Inspector"
echo "=================================================================="

# OSS Audit — Linux Kernel
## Open Source Software Capstone Project

| Field | Details |
|---|---|
| **Student Name** | Trisha |
| **Registration Number** | 24BAC10012 |
| **Repository Name** | oss-audit-24BAC10012 |
| **Course** | Open Source Software (OSS NGMC) |
| **Software Audited** | Linux Kernel |
| **License** | GNU General Public License v2 (GPL v2) |

---

## About This Project

This repository contains the shell scripts for the Open Source Audit capstone project. The project conducts a structured audit of the **Linux Kernel** — examining its origin story, license philosophy, Linux footprint, FOSS ecosystem, and comparison with proprietary alternatives.

The Linux Kernel was chosen because it is the single most impactful open-source project in computing history. Written by Linus Torvalds in 1991 as a personal hobby project, it now powers 96% of the world's top servers, all 500 of the world's fastest supercomputers, and over 3 billion Android devices worldwide.

---

## Repository Structure

```
oss-audit-24BAC10012/
├── README.md                          ← This file
├── script1_system_identity.sh         ← Script 1: System Identity Report
├── script2_package_inspector.sh       ← Script 2: FOSS Package Inspector
├── script3_disk_auditor.sh            ← Script 3: Disk and Permission Auditor
├── script4_log_analyzer.sh            ← Script 4: Log File Analyzer
└── script5_manifesto_generator.sh     ← Script 5: Open Source Manifesto Generator
```

---

## Scripts Overview

### Script 1 — System Identity Report
**File:** `script1_system_identity.sh`

Displays a formatted welcome screen showing the Linux system's identity — kernel version, distribution, architecture, logged-in user, home directory, system uptime, current date and time, and the open-source license covering the OS (GPL v2).

**Concepts used:** Variables, `echo`, command substitution `$()`, string formatting, conditional file check, `uname`, `whoami`, `hostname`, `uptime`, `date`

---

### Script 2 — FOSS Package Inspector
**File:** `script2_package_inspector.sh`

Checks whether the Linux kernel image package is installed on the system, displays version and architecture information, and uses a `case` statement to print a philosophy note about the package.

**Concepts used:** `if-then-else`, `case` statement, `dpkg -l`, `grep`, `awk`, command substitution, string matching

---

### Script 3 — Disk and Permission Auditor
**File:** `script3_disk_auditor.sh`

Loops through a predefined list of important system directories and kernel-specific directories, reporting the permissions, owner, group, and disk usage of each.

**Concepts used:** `for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`, conditional directory existence check `[ -d ]`

---

### Script 4 — Log File Analyzer
**File:** `script4_log_analyzer.sh`

Reads a log file line by line using a `while read` loop, counts how many lines contain a specified keyword (default: "error"), and displays the last 5 matching lines. Accepts log file path and keyword as command-line arguments.

**Concepts used:** `while IFS= read -r` loop, `if-then`, counter variables, command-line arguments `$1 $2`, `grep -iq`, `tail`, `mktemp`, `bc`

**Usage:**
```bash
./script4_log_analyzer.sh /var/log/syslog error
./script4_log_analyzer.sh /var/log/kern.log warning
```

---

### Script 5 — Open Source Manifesto Generator
**File:** `script5_manifesto_generator.sh`

Interactively asks the user three questions about their relationship with open source software, then generates a personalised philosophy statement and saves it to a `.txt` file named after the current user.

**Concepts used:** `read` for interactive input, input validation with `while`, string concatenation with embedded variables, file writing with `>` and `>>`, `date`, `cat`, alias concept demonstrated in comments

---

## Dependencies

All scripts require a **Linux system** (Ubuntu 20.04+ recommended). No additional packages beyond a standard Ubuntu installation are needed.

| Command Used | Package | Pre-installed on Ubuntu? |
|---|---|---|
| `uname`, `whoami`, `hostname` | coreutils | ✅ Yes |
| `dpkg` | dpkg | ✅ Yes |
| `du`, `df` | coreutils | ✅ Yes |
| `grep`, `awk`, `cut` | grep / gawk | ✅ Yes |
| `bc` | bc | Usually yes (install: `sudo apt install bc`) |
| `date`, `uptime` | coreutils | ✅ Yes |

---

## How to Run the Scripts on Linux (Ubuntu)

### Step 1 — Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/oss-audit-24BAC10012.git
cd oss-audit-24BAC10012
```

### Step 2 — Make all scripts executable
```bash
chmod +x *.sh
```

### Step 3 — Run each script

**Script 1:**
```bash
./script1_system_identity.sh
```

**Script 2:**
```bash
./script2_package_inspector.sh
```

**Script 3:**
```bash
./script3_disk_auditor.sh
```

**Script 4:**
```bash
# Basic usage with default keyword 'error'
./script4_log_analyzer.sh /var/log/syslog

# With a custom keyword
./script4_log_analyzer.sh /var/log/syslog warning

# With kernel log
sudo ./script4_log_analyzer.sh /var/log/kern.log error
```

**Script 5:**
```bash
./script5_manifesto_generator.sh
# Follow the interactive prompts
```

---

## Notes

- Scripts 1, 2, 3, and 5 can be run as a regular user
- Script 4 may need `sudo` to access certain log files (e.g., `/var/log/kern.log`)
- All scripts include inline comments explaining every non-obvious line
- Tested on Ubuntu 22.04 LTS running on VirtualBox

---

## References

- GNU Project — Free Software Definition: https://gnu.org/philosophy/free-sw.html
- Open Source Initiative — OSD: https://opensource.org/osd
- Linux Kernel Official Site: https://kernel.org
- The Linux Command Line by William Shotts: https://linuxcommand.org
- SPDX License List (GPL v2): https://spdx.org/licenses/GPL-2.0-only.html

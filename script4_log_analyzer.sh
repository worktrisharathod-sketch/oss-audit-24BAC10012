#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Trisha | Registration: 24BAC10012
# Course: Open Source Software | OSS NGMC Capstone
# Description: Reads a log file line by line, counts keyword
#              occurrences, and prints a summary with matching
#              lines. Accepts log file path and keyword as args.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# ============================================================

# --- Command-line Arguments ---
# $1 = log file path (required)
# $2 = keyword to search for (optional, defaults to "error")
LOGFILE=$1
KEYWORD=${2:-"error"}       # Default keyword is 'error' if not provided

# --- Counter Variables ---
COUNT=0                     # Counts matching lines
TOTAL_LINES=0               # Counts total lines in file

# --- Header ---
echo "=================================================================="
echo "  LOG FILE ANALYZER"
echo "  Student: Trisha | Reg: 24BAC10012"
echo "  Date: $(date '+%d %B %Y %H:%M:%S')"
echo "=================================================================="
echo ""

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    exit 1
fi

# --- Check if the specified log file exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo ""

    # --- Retry suggestion: list available log files ---
    echo "  Available log files in /var/log/:"
    ls /var/log/*.log 2>/dev/null || echo "  No .log files found in /var/log/"
    echo ""

    # Suggest the most commonly available log file
    if [ -f "/var/log/syslog" ]; then
        echo "  TIP: Try using /var/log/syslog as your log file."
        echo "  Run: $0 /var/log/syslog $KEYWORD"
    fi
    exit 1
fi

# --- Check if the file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: The file '$LOGFILE' is empty."
    echo "  Please provide a log file with content."
    exit 1
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo ""
echo "------------------------------------------------------------------"
echo "  SCANNING LOG FILE..."
echo "------------------------------------------------------------------"

# --- Temporary file to store matching lines ---
MATCH_FILE=$(mktemp)        # Creates a temporary file for matched lines

# --- while-read loop: Read log file line by line ---
# IFS= prevents trimming of leading/trailing whitespace
# -r prevents backslash interpretation
while IFS= read -r LINE; do

    # Increment total line counter for every line read
    TOTAL_LINES=$((TOTAL_LINES + 1))

    # --- if-then: Check if this line contains the keyword ---
    # grep -iq: -i = case-insensitive, -q = quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then

        # Increment the match counter
        COUNT=$((COUNT + 1))

        # Save the matching line to temp file for later display
        echo "$LINE" >> "$MATCH_FILE"
    fi

done < "$LOGFILE"           # Feed the log file into the while loop

echo ""
echo "------------------------------------------------------------------"
echo "  ANALYSIS SUMMARY"
echo "------------------------------------------------------------------"
echo "  Total lines scanned : $TOTAL_LINES"
echo "  Keyword matches     : $COUNT"
echo "  Match rate          : $(echo "scale=2; $COUNT * 100 / $TOTAL_LINES" | bc 2>/dev/null || echo "N/A")%"
echo ""

# --- Display results based on match count ---
if [ "$COUNT" -eq 0 ]; then
    echo "  No lines containing '$KEYWORD' were found in $LOGFILE."
else
    echo "  Keyword '$KEYWORD' found $COUNT time(s) in $LOGFILE"
    echo ""
    echo "------------------------------------------------------------------"
    echo "  LAST 5 MATCHING LINES"
    echo "------------------------------------------------------------------"

    # Use tail to display only the last 5 matching lines from temp file
    # This is efficient for large log files
    tail -5 "$MATCH_FILE" | while IFS= read -r MATCH_LINE; do
        # Truncate long lines to 70 characters for clean display
        echo "  >> ${MATCH_LINE:0:70}"
    done
fi

echo ""
echo "------------------------------------------------------------------"
echo "  CONNECTION TO LINUX KERNEL"
echo "------------------------------------------------------------------"
echo "  Linux kernel events are logged to /var/log/syslog and"
echo "  /var/log/kern.log. Because Linux is open source, the logging"
echo "  code itself is readable and auditable — unlike proprietary OS"
echo "  logging systems where you cannot see what is recorded or why."
echo ""

# --- Clean up the temporary file ---
rm -f "$MATCH_FILE"

echo "=================================================================="
echo "  End of Log File Analyzer"
echo "=================================================================="

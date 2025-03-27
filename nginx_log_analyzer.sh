#!/bin/bash

#------------------------
# Nginx Log Analyzer
#------------------------

# Variables
LOGFILE="$1"

# Validate input
if [ -z "$LOGFILE" ]; then
  echo "Please provide a file to analyze"
  exit 1
fi

if [ ! -f "$LOGFILE" ]; then
  echo "File does not exist: $LOGFILE"
  exit 1
fi

# Analyze log file
echo "Analyzing log file: $LOGFILE"

# Top 5 IP addresses with the most requests
echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -n 5

# Top 5 most requested paths
echo "Top 5 most requested paths:"
awk '{print $7}' "$LOGFILE" | sort | uniq -c | sort -nr | head -n 5

# Top 5 Response Status Codes
echo "Top 5 Response Status Codes:"
awk '{print $9}' "$LOGFILE" | sort | uniq -c | sort -nr | head -n 5

# Top 5 User Agents
echo "Top 5 User Agents:"
awk -F\" '{print $6}' "$LOGFILE" | sort | uniq -c | sort -nr | head -n 5

echo "Analysis complete."

# Exit
exit 0
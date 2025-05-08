#!/bin/bash

# Define SRA file names for all files ending with _counts.txt
SRA_FILES=( *_counts.txt )

# Step 1: Extract first and last columns from the first SRA file and save to output.csv
FIRST_FILE="${SRA_FILES[0]}"
if [ -f "$FIRST_FILE" ]; then
    awk '{print $1 "," $NF}' "$FIRST_FILE" > output.csv
else
    echo "Error: $FIRST_FILE not found!"
    exit 1  # Exit script if the first file is missing
fi

# Step 2: List available .txt files for debugging
echo "Available .txt files in the directory:"
ls -l *.txt

# Step 3: Process remaining trimmed files
for file in "${SRA_FILES[@]:1}"; do
    if [ -f "$file" ]; then
        # Extract only the last column and append to output.csv
        awk '{print $NF}' "$file" | paste -d, output.csv - > output2.csv
        mv output2.csv output.csv
    else
        echo "Warning: File $file not found!"
    fi
done

# Final message
echo "Processing complete! Combined output saved to output.csv."

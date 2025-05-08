#!/bin/bash

# Set the path to the input directory (current directory)
input_dir=$(pwd)

# Path to the custom combined adapter file
adapter_file="$input_dir/adapters/adapter.txt"

# Loop over all .fastq files in the input directory
for file in "$input_dir"/*.fastq; do
    # Extract filename without extension
    filename=$(basename "$file" .fastq)

    echo "🔄 Processing $filename.fastq ..."

    # Run Trimmomatic with adapter trimming and quality filters
    java -jar trimmomatic-0.39.jar SE -threads 32 \
        "$file" "$input_dir/${filename}_trimmed.fastq" \
        ILLUMINACLIP:"$adapter_file":2:30:10 \
        SLIDINGWINDOW:4:20 TRAILING:10 MINLEN:36 \
        -phred33 2> "$input_dir/${filename}_trim_log.txt"

    echo "✅ Done: ${filename}_trimmed.fastq"
    echo "📄 Log saved to ${filename}_trim_log.txt"
    echo "-----------------------------------------"
done

echo "🎉 All FASTQ files have been processed!"

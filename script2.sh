#!/bin/bash

# Set input and output directories
INPUT_DIR=$(dirname "${BASH_SOURCE[0]}")
OUTPUT_DIR="${INPUT_DIR}"

# Check if the input directory exists
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Input directory $INPUT_DIR does not exist!"
    exit 1
fi

# Loop through all fastq files in the input directory
for FASTQ_FILE in ${INPUT_DIR}/*_trimmed.fastq
do
    # Check if the FASTQ file exists
    if [ ! -f "$FASTQ_FILE" ]; then
        echo "Warning: No FASTQ files found in $INPUT_DIR!"
        break
    fi

    # Get the filename without the extension
    FILENAME=$(basename ${FASTQ_FILE} .fastq)
    
    # Align the reads and sort the resulting BAM file
    echo "Aligning $FASTQ_FILE to the reference genome..."
    hisat2 -q --rna-strandness R -x grch38/genome -U ${FASTQ_FILE} -p 32 | samtools sort -o ${OUTPUT_DIR}/${FILENAME}.bam
    
    if [ $? -eq 0 ]; then
        echo "Successfully created ${FILENAME}_trimmed.bam"
    else
        echo "Error processing $FASTQ_FILE"
    fi
done



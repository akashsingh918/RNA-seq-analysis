#!/bin/bash

INPUT_DIR=$(dirname "${BASH_SOURCE[0]}")
OUTPUT_DIR="${INPUT_DIR}"

for BAM_FILE in "${INPUT_DIR}"/*_trimmed.bam
do
    FILENAME=$(basename "${BAM_FILE}" _trimmed.bam)
    
    # Run featureCounts with single-end, reverse-stranded data
    featureCounts -T 8 -s 2 -a Homo_sapiens.GRCh38.106.gtf -o "${OUTPUT_DIR}/${FILENAME}_counts.txt" "${BAM_FILE}"
done

script1.sh – SRA Data Download and Conversion
Downloads raw RNA-Seq data from SRA using prefetch and fasterq-dump

Converts .sra files to .fastq format

Organizes FASTQ files for downstream analysis

script2.sh – Quality Control
Performs quality checks on FASTQ files using FastQC

Aggregates QC reports using MultiQC

Helps assess read quality before alignment

script3.sh – Read Trimming and Alignment
Trims low-quality bases and adapter sequences using Trimmomatic or fastp

Aligns reads to the reference genome using HISAT2 or STAR

Sorts and indexes alignment files using SAMtools

script4.sh – Read Count Compilation
Compiles raw read counts for each gene or transcript across all samples

Outputs a count matrix suitable for input into differential expression tools such as DESeq2

Uses featureCounts, HTSeq-count, or a custom summarization script (depending on implementation)
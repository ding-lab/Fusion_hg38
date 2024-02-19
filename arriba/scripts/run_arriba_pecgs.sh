#!/bin/bash

input_file=$1

# Check if the input file exists
if [ -f "$input_file" ]; then
  # Do something with the input file, such as reading its contents
  echo "Successfully read sample list"
  #cat $input_file
else
  # Print an error message if the input file does not exist
  echo "Error: input file does not exist"
fi

# For more information about this demo workflow, visit: https://arriba.readthedocs.io/en/latest/workflow/

#if [ $# -lt 8 -o $# -gt 9 ]; then
#	echo "Usage: $(basename $0) STAR_genomeDir/ annotation.gtf assembly.fa blacklist.tsv known_fusions.tsv protein_domains.gff3 threads read1.fastq.gz [read2.fastq.gz]" 1>&2
#	exit 1
#fi

# tell bash to be verbose and to abort on error
set -o pipefail
set -x -e -u

export LANG=C
# Activate environment
# Read in arguments
#sample=$1
#fq_1=$2
#fq_2=$3
#cpu=$4
#worklist=1
#sample="$(sed -n "${LSB_JOBINDEX}p" work.list)"
sample="$(sed -n "${LSB_JOBINDEX}p" $input_file)"
#fq_1="$(sed -n "${LSB_JOBINDEX}p" work.list)_1.fastq.gz"
#fq_2="$(sed -n "${LSB_JOBINDEX}p" work.list)_2.fastq.gz"
#cpu=2
# get arguments
STAR_INDEX_DIR="/storage1/fs1/dinglab/Active/Projects/Datasets/arriba/STAR_index_hg38_GENCODE37"
ANNOTATION_GTF="/storage1/fs1/dinglab/Active/Projects/Datasets/arriba/STAR_index_hg38_GENCODE37/GENCODE37.gtf"
ASSEMBLY_FA="/storage1/fs1/dinglab/Active/Projects/Datasets/arriba/STAR_index_hg38_GENCODE37/hg38.fa"
BLACKLIST_TSV="/storage1/fs1/dinglab/Active/Projects/Datasets/arriba/database/blacklist_hg38_GRCh38_v2.2.1.tsv.gz"
KNOWN_FUSIONS_TSV="/storage1/fs1/dinglab/Active/Projects/Datasets/arriba/database/known_fusions_hg38_GRCh38_v2.2.1.tsv.gz"
TAGS_TSV="$KNOWN_FUSIONS_TSV" # different files can be used for filtering and tagging, but the provided one can be used for both
PROTEIN_DOMAINS_GFF3="/storage1/fs1/dinglab/Active/Projects/Datasets/arriba/database/protein_domains_hg38_GRCh38_v2.2.1.gff3"
THREADS=16
READ1="$(sed -n "${LSB_JOBINDEX}p" $input_file)_1.fastq.gz"
READ2="$(sed -n "${LSB_JOBINDEX}p" $input_file)_2.fastq.gz"

# Make directories
cd ${sample}
mkdir -p arriba_Fusion
cd arriba_Fusion
# find installation directory of arriba
#BASE_DIR=$(dirname "$0")
BASE_DIR="/arriba_v2.2.1"

# align FastQ files (STAR >=2.7.10a recommended)
STAR \
	--runThreadN "$THREADS" \
	--genomeDir "$STAR_INDEX_DIR" --genomeLoad NoSharedMemory \
	--readFilesIn "../$READ1" "../$READ2" --readFilesCommand zcat \
	--outStd BAM_Unsorted --outSAMtype BAM Unsorted --outSAMunmapped Within --outBAMcompression 0 \
	--outFilterMultimapNmax 50 --peOverlapNbasesMin 10 --alignSplicedMateMapLminOverLmate 0.5 --alignSJstitchMismatchNmax 5 -1 5 5 \
	--chimSegmentMin 10 --chimOutType WithinBAM HardClip --chimJunctionOverhangMin 10 --chimScoreDropMax 30 --chimScoreJunctionNonGTAG 0 --chimScoreSeparation 1 --chimSegmentReadGapMax 3 --chimMultimapNmax 50 |

tee Aligned.out.bam |

# call arriba
"$BASE_DIR/arriba" \
	-x /dev/stdin \
	-o fusions.tsv -O fusions.discarded.tsv \
	-a "$ASSEMBLY_FA" -g "$ANNOTATION_GTF" -b "$BLACKLIST_TSV" -k "$KNOWN_FUSIONS_TSV" -t "$TAGS_TSV" -p "$PROTEIN_DOMAINS_GFF3" \
#	-d structural_variants_from_WGS.tsv

# sorting and indexing is only required for visualization
if [[ $(samtools --version-only 2> /dev/null) =~ ^1\. ]]; then
	samtools sort -@ "$THREADS" -m $((40000/THREADS))M -T tmp -O bam Aligned.out.bam > Aligned.sortedByCoord.out.bam
	rm -f Aligned.out.bam
	samtools index Aligned.sortedByCoord.out.bam
else
	echo "samtools >= 1.0 required for sorting of alignments" 1>&2
fi
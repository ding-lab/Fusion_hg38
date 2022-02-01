#!/bin/bash

# Activate environment
#source /diskmnt/Projects/Users/ysong/program/anaconda3/etc/profile.d/conda.sh
#conda activate Fusion

# Read in arguments
sample=$1
fq_1=$2
fq_2=$3
cpu=$4

# Make directories
cd ${sample}
mkdir -p logs

# STAR-Fusion

# STAR 2.7.1a
#genome_lib_dir=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/STAR-Fusion_dependencies/GRCh38_gencode_v31_CTAT_lib_Oct012019.plug-n-play/ctat_genome_lib_build_dir

#STAR version: 2.7.8a
genome_lib_dir=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/STAR-Fusion_dependencies/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir

mkdir -p STAR_FUSION
STAR-Fusion --left_fq $fq_1 --right_fq $fq_2 --CPU $cpu --examine_coding_effect -O STAR_FUSION --genome_lib_dir $genome_lib_dir --verbose_level 2 1> logs/STAR-Fusion.out 2> logs/STAR-Fusion.err

# Cleanup big files from STAR-Fusion
rm STAR_FUSION/Aligned.out.bam
rm -r STAR_FUSION/star-fusion.preliminary
rm -r STAR_FUSION/_*
gzip STAR_FUSION/Chimeric.out.junction

# EricScript
genome_db=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/ericscript_dependencies/ericscript_db_homosapiens_ensembl84
/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/ericscript-0.5.5/ericscript.pl -o ERICSCRIPT --remove -ntrim 0 --refid homo_sapiens -db $genome_db -p $cpu -name $sample $fq_1 $fq_2 1> logs/ericscript.out 2> logs/ericscript.err

## Integrate
# STAR
mkdir -p STAR
cd STAR
STAR --runThreadN 80 --genomeDir /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/STAR-Fusion_dependencies/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir/ref_genome.fa.star.idx --readFilesCommand zcat --readFilesIn ../${fq_1} ../${fq_2} --outSAMtype BAM Unsorted --outFileNamePrefix star --chimSegmentMin 18 --chimOutType WithinBAM --outSAMunmapped Within 1> ../logs/star.out 2> ../logs/star.err
samtools sort starAligned.out.bam starAligned.out.sorted
samtools index starAligned.out.sorted.bam
cd ..

# Run Integrate
bwts=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Integrate_dependencies/bwts
bam_dir=STAR
fasta=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Integrate_dependencies/STAR/hg38.fa
annot=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Integrate_dependencies/annot.ensembl.GRCh38.txt
mkdir -p INTEGRATE
Integrate fusion -reads INTEGRATE/reads.txt -sum INTEGRATE/summary.tsv -ex INTEGRATE/exons.tsv -bk INTEGRATE/breakpoints.tsv -vcf INTEGRATE/bk_sv.vcf -bedpe INTEGRATE/fusions.bedpe $fasta $annot $bwts $bam_dir/starAligned.out.sorted.bam $bam_dir/starAligned.out.sorted.bam 1> logs/Integrate.out 2> logs/Integrate.err

# Cleanup big files from Integrate
rm STAR/starAligned.out.bam
rm STAR/starAligned.out.sorted.bam
rm STAR/starAligned.out.sorted.bam.bai
rm -r STAR/star_STARtmp

#Merge three tools
mkdir -p Merged_Fusions
perl /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/combine_call.pl $sample STAR_FUSION/star-fusion.fusion_predictions.abridged.coding_effect.tsv ERICSCRIPT/${sample}.results.total.tsv INTEGRATE/summary.tsv INTEGRATE/breakpoints.tsv Merged_Fusions 1> logs/Merge.out 2> logs/Merge.err

#Filtering
perl /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/filter.pl Merged_Fusions $sample 1> logs/Filter.out 2> logs/Filter.err

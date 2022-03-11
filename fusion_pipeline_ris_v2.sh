#!/bin/bash
export PATH=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/INTEGRATE_0_2_6/INTEGRATE-build/bin:$PATH
export LD_LIBRARY_PATH="/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/INTEGRATE_0_2_6/INTEGRATE-build/vendor/divsufsort/lib:$LD_LIBRARY_PATH"
export LANG=C
# Activate environment
#source /diskmnt/Projects/Users/ysong/program/anaconda3/etc/profile.d/conda.sh
source activate Fusion || echo activate failed

# Read in arguments
sample=$1
fq_1=$2
fq_2=$3
cpu=$4

# Make directories
cd ${sample}
mkdir -p logs

# STAR-Fusion

#STAR version: 2.7.8a
genome_lib_dir=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/STAR-Fusion_dependencies/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir

mkdir -p STAR_FUSION
STAR-Fusion --left_fq $fq_1 --right_fq $fq_2 --CPU $cpu --examine_coding_effect -O STAR_FUSION --genome_lib_dir $genome_lib_dir --verbose_level 2 1> logs/STAR-Fusion.out 2> logs/STAR-Fusion.err
samtools sort STAR_FUSION/Aligned.out.bam STAR_FUSION/starAligned.out.sorted
samtools index STAR_FUSION/starAligned.out.sorted.bam

# EricScript
genome_db=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/ericscript_dependencies/ericscript_db_homosapiens_ensembl84
ericscript.pl -o ERICSCRIPT --remove -ntrim 0 --refid homo_sapiens -db $genome_db -p $cpu -name $sample $fq_1 $fq_2 1> logs/ericscript.out 2> logs/ericscript.err


# Run Integrate
bwts=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Integrate_dependencies/bwts
bam_dir=STAR_FUSION
fasta=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/STAR-Fusion_dependencies/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir/ref_genome.fa
annot=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Integrate_dependencies/annot.genecode.v37.GRCh38.txt

mkdir -p INTEGRATE
Integrate fusion -reads INTEGRATE/reads.txt -sum INTEGRATE/summary.tsv -ex INTEGRATE/exons.tsv -bk INTEGRATE/breakpoints.tsv -vcf INTEGRATE/bk_sv.vcf -bedpe INTEGRATE/fusions.bedpe $fasta $annot $bwts $bam_dir/starAligned.out.sorted.bam $bam_dir/starAligned.out.sorted.bam 1> logs/Integrate.out 2> logs/Integrate.err

#Merge three tools
mkdir -p Merged_Fusions
perl /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/combine_call.pl $sample STAR_FUSION/star-fusion.fusion_predictions.abridged.coding_effect.tsv ERICSCRIPT/${sample}.results.total.tsv INTEGRATE/summary.tsv INTEGRATE/breakpoints.tsv Merged_Fusions 1> logs/Merge.out 2> logs/Merge.err

#Filtering
perl /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/filter.pl Merged_Fusions $sample 1> logs/Filter.out 2> logs/Filter.err

# Cleanup big files from STAR-Fusion & Integrate
rm STAR_FUSION/Aligned.out.bam
rm -r STAR_FUSION/star-fusion.preliminary
rm -r STAR_FUSION/_*
gzip STAR_FUSION/Chimeric.out.junction
rm STAR_FUSION/starAligned.out.sorted.bam
rm STAR_FUSION/starAligned.out.sorted.bam.bai
rm -r STAR_FUSION/star_STARtmp

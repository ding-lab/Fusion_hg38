
## Integrate wiki
https://sourceforge.net/p/integrate-fusion/wiki/Home/

## We updated the Intergrate annotation files to in consistence with the updated STAR_Fusion and EricScript

Installation
For details of Installation of INTEGRATE, go to [Installation].

Preparation
(1) Get annotation from UCSC Genome Browser http://genome.ucsc.edu

For details of downloading annotation, go to [annotation].
annot.ucsc.txt, containing UCSC genes can be download at https://sourceforge.net/projects/integrate-fusion/files/.

(2) Get accepted_hits.bam and unmapped.bam

by mapping tumor RNA-Seq reads with tools like TopHat http://tophat.cbcb.umd.edu/.
￼￼￼￼￼￼
Note: please use TopHat 2.

(3) Get dna.tumor.bam

by mapping WGS tumor reads with tools like BWA http://bio-bwa.sourceforge.net/.

Note: BWA turns soft-clip on by default. Make sure soft-clip is turn on if using other tools

(4) If there are normal WGS reads, get dna.normal.bam

(5) index all the BAM files with samtools index (refer to http://samtools.sourceforge.net/).

(6) build BWTs
mkdir ./bwts
Integrate mkbwt reference.fasta*

Integrate mkbwt /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/STAR-Fusion_dependencies/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir/ref_genome.fa*

Note: This step takes about 20-30 minutes, but only needs to run once.

Call Fusions
Integrate fusion (options) reference.fasta annotation.txt directory_to_bwt accepted_hits.bam unmapped.bam (dna.tumor.bam dna.normal.bam)

options
For details of options, go to [options]

output files
For details of output files, go to [output]

annotation  
Authors: Jin
Please refer to Appendix A. Getting gene annotation file from UCSC Genome Browser at https://sourceforge.net/projects/integrate-fusion/files/, which contains the method of downloading annotation file for UCSC genes, Ensembl genes, Gencode genes, or RefSeq genes for INTEGRATE version 0.2.0 and previous versions.

Since INTEGRATE version 0.2.5, the annotation file uses 11 columns. Two additional columns cdsStart and cdsEnd are added to the annotation file. Please refer to the annot.enseml.txt annotation file at https://sourceforge.net/projects/integrate-fusion/files/ as an example.

The above annotation file can also be created using a GTF file, for example:
a. Download the GTF file at ftp://ftp.ensembl.org/pub/release-75/gtf/homo_sapiens/Homo_sapiens.GRCh37.75.gtf.gz.
b. Run the following commands:
(1)gtfToGenePred -genePredExt -geneNameAsName2 Homo_sapiens.GRCh37.75.gtf Homo_sapiens.GRCh37.75.genePred
(2) cut -f 1-10,12 Homo_sapiens.GRCh37.75.genePred > tmp.txt
(3) echo -e "#GRCh37.ensGene.name\tGRCh37.ensGene.chrom\tGRCh37.ensGene.strand\tGRCh37.ensGene.txStart\tGRCh37.ensGene.txEnd\tGRCh37.ensGene.cdsStart\tGRCh37.ensGene.cdsEnd\tGRCh37.ensGene.exonCount\tGRCh37.ensGene.exonStarts\tGRCh37.ensGene.exonEnds\tGRCh37.ensemblToGeneName.value" > annot.ensembl.GRCh37.txt
(4) cat tmp.txt >> annot.ensembl.GRCh37.txt

To use GRCh38/hg38, only an annotation file for GRCh38 and a reference file for GRCh38/hg38 need to be created or downloaded.

cd /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Integrate_dependencies

gtfToGenePred -genePredExt -geneNameAsName2 gencode.v39lift37.annotation.gtf gencode.v39lift37.annotation.genePred

cut -f 1-10,12 gencode.v39lift37.annotation.genePred > tmp.txt

echo -e "#GRCh38.ensGene.name\tGRCh38.ensGene.chrom\tGRCh38.ensGene.strand\tGRCh38.ensGene.txStart\tGRCh38.ensGene.txEnd\tGRCh38.ensGene.cdsStart\tGRCh38.ensGene.cdsEnd\tGRCh38.ensGene.exonCount\tGRCh38.ensGene.exonStarts\tGRCh38.ensGene.exonEnds\tGRCh38.ensemblToGeneName.value" > annot.genecode.v37.GRCh38.txt

cat tmp.txt >> annot.genecode.v37.GRCh38.txt


##
gtfToGenePred -genePredExt -geneNameAsName2 gencode.v39.annotation.gtf gencode.v39.annotation.genePred

cut -f 1-10,12 gencode.v39.annotation.genePred > tmp.txt

echo -e "#GRCh38.ensGene.name\tGRCh38.ensGene.chrom\tGRCh38.ensGene.strand\tGRCh38.ensGene.txStart\tGRCh38.ensGene.txEnd\tGRCh38.ensGene.cdsStart\tGRCh38.ensGene.cdsEnd\tGRCh38.ensGene.exonCount\tGRCh38.ensGene.exonStarts\tGRCh38.ensGene.exonEnds\tGRCh38.ensemblToGeneName.value" > annot.genecode.v39.GRCh38.txt

cat tmp.txt >> annot.genecode.v39.GRCh38.txt

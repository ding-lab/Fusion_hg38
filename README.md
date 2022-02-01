## Fusion_hg38

Fusion Pipeline officially works on RIS compute1. :hugs: In the mean time, here are the new hightlights:

1. Suitable for batch jobs and large projects, providing the project has the catalog in these format

   [Alchemist.RNA.Map](https://github.com/ding-lab/GDAN.catalog/blob/main/Alchemist/Alchemist.RNAMap.storage1.tsv);
   [CPTAC3.BamMap](https://github.com/ding-lab/CPTAC3.catalog/blob/master/BamMap/storage1.BamMap.dat);
   [PE-CGS.FileMap](https://github.com/ding-lab/PE-CGS.catalog/blob/main/FileMap/FileMap.tsv)
   
2. Currently, this Fusion pipeline is designed to work for 3 main projects: PE-CGS, ALCHEMIST and CPTAC3


## Major Updates:

1. Updated STAR v2.7.2c to [STAR v2.7.8a](https://github.com/alexdobin/STAR/releases/tag/2.7.8a) 
2. Updated STAR-Fusion v1.7.0 to [STAR-Fusion v1.10.0](https://github.com/STAR-Fusion/STAR-Fusion/releases/tag/v1.10.0)
3. Updated ctat genome libs, from GRCh38_gencode_v31_CTAT_lib_Oct012019 to [GRCh38_gencode_v37_CTAT_lib_Mar012021](https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/__genome_libs_StarFv1.10/)


Last updated: 01/13/22

Adapted from [Dan Cui Zhou's hg38 pipeline v2.2](https://github.com/sscien/Fusion_hg38) and Qingsong Gao's hg19 pipeline

### VERSION: v2.6

### Build: hg38 (GRCh38_gencode_v31)

### Cluster: Compute1

### Compute resources: at least 50GB MEM and 150 GB disk space for each sample

Three tools are used for fusion calling:
Databases and references were downloaded from their respective websites.

STAR-Fusion is downloaded from https://github.com/STAR-Fusion/STAR-Fusion/wiki

[EricScript](https://academic.oup.com/bioinformatics/article/28/24/3232/247436) is downloaded from https://sites.google.com/site/bioericscript

```
EricScript is currently located in /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/ericscript-0.5.5 
since the docker version EricScript have this issue https://github.com/ding-lab/Fusion_hg38/issues/1
```

Integrate is downloaded from https://sourceforge.net/p/integrate-fusion/wiki/Home/

```
Integrate is located in /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/INTEGRATE_0_2_6
```

Fusion pipeline:
Fusions are called by each tool then merged into a single file. This is done for tumor and normal RNA-Seq files individually.
Since raw fusion calls may contain many false positives, extensive filtering is done, as detailed below.
Finally, normal fusions are then filtered out from the tumor fusions.

Filtering strategy:
Get fusions reported by at least 2 callers or reported by STAR-Fusion (shows higher sensitivity) but with higher supporting evidence (defined by fusion fragments per million total reads, or FFPM, >0.1).
Then, remove fusions present in the filtering database, which includes:
1) Uncharacterized genes, immunoglobin genes, mitochondrial genes, etc.
2) Fusions from the same gene or paralog genes (downloaded from https://www.genenames.org/cgi-bin/statistics)
3) Fusions reported in TCGA normal samples from pancan fusion analysis (PMID:29617662), GTEx tissues (reported in star-fusion output), and non-cancer cell studies (PMID: 26837576)

Output format:
In the output file, each row represents one fusion.
There are 9 columns for each fusion:
1) FusionName
2) LeftBreakpoint
3) RightBreakpoint
4) Cancer__Sample
5) JunctionReadCount
6) SpanningFragCount
7) FFPM 		- fusion fragments per million total reads, 'NA' means the fusion was found by both EricScript and Integrate but not STAR-Fusion
8) PROT_FUSION_TYPE 	- INFRAME, FRAMESHIFT or '.'
9) CallerN 		- number of callers

Processing details:
Run "makeDir.py" to create the appropriate folder directory for each sample.
Run "to_run.sh" in order to submit tmux instances.
Once it's all done, run "normalFilter.py" to remove normal fusions.

v2.2 revision history:
Fixed bug that basically ignored Integrate calls
Automatically compresses large Star fusion file
Added a copy any fusion script so we can provide normal calls too (no longer filtering germline by default)

## Usage

add the following into bashrc or bash_profile on compute1
```
export PATH=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/INTEGRATE_0_2_6/INTEGRATE-build/bin:$PATH
export LD_LIBRARY_PATH="/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/INTEGRATE_0_2_6/INTEGRATE-build/vendor/divsufsort/lib:$LD_LIBRARY_PATH"
```


1. pull fusion docker on compute1
```
LSF_DOCKER_VOLUMES="$STORAGE1_DINGLAB:$STORAGE1_DINGLAB" PATH="$STORAGE1_DINGLAB:$PATH" bsub -Is -q 'dinglab-interactive general-interactive' -G compute-dinglab -M 50G -R 'select[mem>50G] span[hosts=1] rusage[mem=50G]' -a 'docker(songyizhe/fusion:2.6)' /bin/bash -l
```
2. Read in samples and make directory and symblinks for each sample

```
## Worklog -- This is how I processed Alchemist data for fusion hg38 pipeline

## cd to the folder for fusion analysis
cd /storage1/fs1/dinglab/Active/Projects/ALCHEMIST/Alchemist_analysis/RNA-seq_Fusion_Alchemist_batch_01_11_22

## download the ALCHEMIST catalog to the folder

wget https://raw.githubusercontent.com/ding-lab/GDAN.catalog/main/Alchemist/Alchemist.RNAMap.storage1.tsv

## Get the sample_name and save to samples.txt

grep ALCH Alchemist.RNAMap.storage1.tsv | cut -f 1 | rev | cut -c6- | rev | sort | uniq > samples.txt

# cut first column, reverse the character order, cut the last 6 character, reverse back, sort, keep unique sample names

## make directories for each sample in the subfolder of the current folder.

python makeDir_ris_alchemist.py samples.txt Alchemist.RNAMap.storage1.tsv .

```


3. activate conda env
```
conda activate Fusion
```
or 

```
source activate Fusion
```
4. Run fusion

Example script (generated from step 2)
```
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh ALCH-B2NW-TTP1-A ALCH-B2NW-TTP1-A_1.fastq.gz ALCH-B2NW-TTP1-A_2.fastq.gz 10
```

## Contact

EJ Song (y.song@wustl.edu)

Thanks a lot to Qingsong and Daniel Cui Zhou who initially developed and optimized this pipeline.

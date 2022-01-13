## Fusion_hg38

Fusion Pipeline officially works on RIS compute1. :hugs: In the mean time, here are the new hightlights:

1. Suitable for batch jobs and large projects, providing the project has the catalog in these format

   [Alchemist.RNA.Map](https://github.com/ding-lab/GDAN.catalog/blob/main/Alchemist/Alchemist.RNAMap.storage1.tsv);
   [CPTAC3.BamMap](https://github.com/ding-lab/CPTAC3.catalog/blob/master/BamMap/storage1.BamMap.dat);
   [PE-CGS.FileMap](https://github.com/ding-lab/PE-CGS.catalog/blob/main/FileMap/FileMap.tsv)
   
2. Currently, this Fusion pipeline is designed to work for 3 main projects: PE-CGS, ALCHEMIST and CPTAC3


## Major Updates:

1. updated STAR version=2.7.2c to [STAR v2.7.8a](https://github.com/alexdobin/STAR/releases/tag/2.7.8a) 
2. updated STAR-Fusion=1.7.0   to [STAR-Fusion Release v1.10.0](https://github.com/STAR-Fusion/STAR-Fusion/releases/tag/v1.10.0)
3. updated ctat genome libs, from GRCh38_gencode_v31_CTAT_lib_Oct012019 to [GRCh38_gencode_v37_CTAT_lib_Mar012021](https://data.broadinstitute.org/Trinity/CTAT_RESOURCE_LIB/__genome_libs_StarFv1.10/)


Last updated: 01/13/22

Adapted from [Dan Cui Zhou's hg38 pipeline v2.2](https://github.com/sscien/Fusion_hg38) and Qingsong Gao's hg19 pipeline

VERSION: v2.6
Build: hg38 (GRCh38_gencode_v31)
Cluster: Compute1

Three tools are used for fusion calling:
Databases and references were downloaded from their respective websites.
STAR-Fusion is downloaded from https://github.com/STAR-Fusion/STAR-Fusion/wiki
EricScript is downloaded from https://sites.google.com/site/bioericscript
Integrate is downloaded from https://sourceforge.net/p/integrate-fusion/wiki/Home/

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


## Contact

EJ Song (y.song@wustl.edu)

Thanks a lot to Qingsong and Daniel Cui Zhou who initially developed and optimized this pipeline.

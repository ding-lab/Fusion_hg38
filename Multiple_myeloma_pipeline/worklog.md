find /storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ -type f > /storage1/fs1/dinglab/Active/Projects/ysong/Projects/Fusion_hg38/Multiple_myeloma/MM_RNA_seq_Fusion_batch_0122/samplepath.txt


## from Lijun, ignore “htcf.wustl.edu” folder. These records were deleted
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/58413.ACCTTGGC-GGCCTCAT/58413.ACCTTGGC-GGCCTCAT.HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R1.paired.fq.gz
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/58413.ACCTTGGC-GGCCTCAT/58413.ACCTTGGC-GGCCTCAT.HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R2.paired.fq.gz
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/58413.ACCTTGGC-GGCCTCAT/58413.ACCTTGGC-GGCCTCAT.HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R2.unpaired.fq.gz
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/58413.ACCTTGGC-GGCCTCAT/58413.ACCTTGGC-GGCCTCAT.HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R1.unpaired.fq.gz
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/58413.ACCTTGGC-GGCCTCAT/58413.ACCTTGGC-GGCCTCAT.HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R1.fastq.gz
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/58413.ACCTTGGC-GGCCTCAT/58413.ACCTTGGC-GGCCTCAT.HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R2.fastq.gz
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/FastQC/HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R2_fastqc.html
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/FastQC/HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R1_fastqc.zip
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/FastQC/HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R2_fastqc.zip
/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MMRF/RNASeq_tumor_FASTQ/htcf.wustl.edu/files/5d9ykjdO/Vij_s5059_MGI0497/FastQC/HFY35DSXY_ACCTTGGC-GGCCTCAT_L002_R1_fastqc.html![image](https://user-images.githubusercontent.com/80489022/155205084-61037f35-7724-4b3d-bbeb-a660f54faec3.png)

Curating the catalog, upload it to github

https://raw.githubusercontent.com/ding-lab/Fusion_hg38/main/Multiple_myeloma_pipeline/MMRF_catalog.tsv



## Worklog -- This is how I processed Alchemist data for fusion hg38 pipeline

cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/Fusion_hg38/Multiple_myeloma/MM_RNA_seq_Fusion_batch_0122/


## cd to the folder for fusion analysis
cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/Fusion_hg38/Multiple_myeloma/MM_RNA_seq_Fusion_batch_0122/


## download the ALCHEMIST catalog to the folder

wget https://raw.githubusercontent.com/ding-lab/Fusion_hg38/main/Multiple_myeloma_pipeline/MMRF_catalog.tsv

## Activate the Fusion environment

fusion

## Optional, depends on whether the filemap is tab delimited, if yes, use the tsv_to_txt.py
## convert filemap format, from tab-separated values (TSV) file to a comma-separated values (txt) file in python) 

# python3 tsv_to_txt.py Alchemist.RNAMap.storage1.tsv Alchemist.RNAMap.storage1.txt

## Get the sample_name and save to samples.txt

grep SRR MMRF_catalog.tsv | cut -f 1 | sort | uniq > samples.txt

# cut first column, sort, keep unique sample names

## make directories for each sample in the subfolder of the current folder.
fusion

cp /storage1/fs1/dinglab/Active/Projects/ALCHEMIST/Alchemist_analysis/RNA-seq_Fusion_Alchemist/makeDir_ris_alchemist.py .
python makeDir_ris_alchemist.py samples.txt MMRF_catalog.tsv .

split -l 20 toRun_priority.sh toRun_priority_



## head samples.txt
SRR1567025
SRR1567026
SRR1567027
SRR1567028
SRR1567029
SRR1567030
SRR1567031
SRR1567032
SRR1567033



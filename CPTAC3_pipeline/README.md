### 2022 CPTAC3 fusion pipeline

cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/Fusion_hg38/
mkdir GBM
cd GBM
mkdir GBM_RNA_seq_Fusion_batch_2022_02_11
cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/Fusion_hg38/GBM/GBM_RNA_seq_Fusion_batch_2022_02_11

#GBM_2022_02_11_fusion.tsv
#run_name	case_id	tumor_name	rna_raw__sample__R1__tumor_UUID	rna_raw__sample__R2__tumor_UUID	rna_raw__sample__R1__data_path	rna_raw__sample__R2__data_path
C1230738-TR1	C1230738	C1230738-TR1	a0573c53-73bc-4841-8fb6-e5ae0bf87740	eb68c408-9b99-4474-a4aa-8e8282e65874	/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/CPTAC3-GDC/GDC_import/data/a0573c53-73bc-4841-8fb6-e5ae0bf87740/210713_UNC32-K00270_0291_AHLK5VBBXY_CGGCGTGA-GCGCCTGT_S14_L004_R1_001.fastq.gz	/storage1/fs1/m.wyczalkowski/Active/Primary/CPTAC3.share/CPTAC3-GDC/GDC_import/data/eb68c408-9b99-4474-a4aa-8e8282e65874/210713_UNC32-K00270_0291_AHLK5VBBXY_CGGCGTGA-GCGCCTGT_S14_L004_R2_001.fastq.gz

fusion
source activate Fusion
python makeDir_v3.1_CPTAC.py GBM_2022_02_11_fusion.tsv .

bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C1230738-TR1 C1230738-TR1_1.fastq.gz C1230738-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C1230738-TP C1230738-TP_1.fastq.gz C1230738-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C1245129-TP C1245129-TP_1.fastq.gz C1245129-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C204057-TR1 C204057-TR1_1.fastq.gz C204057-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C204057-TP C204057-TP_1.fastq.gz C204057-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C207624-TR1 C207624-TR1_1.fastq.gz C207624-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C207624-TP C207624-TP_1.fastq.gz C207624-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C208854-TP C208854-TP_1.fastq.gz C208854-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C217710-TP C217710-TP_1.fastq.gz C217710-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C219555-TR1 C219555-TR1_1.fastq.gz C219555-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C223491-TR1 C223491-TR1_1.fastq.gz C223491-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C224106-TR1 C224106-TR1_1.fastq.gz C224106-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C224106-TP C224106-TP_1.fastq.gz C224106-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C224967-TR1 C224967-TR1_1.fastq.gz C224967-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C224967-TP C224967-TP_1.fastq.gz C224967-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C229764-TR1 C229764-TR1_1.fastq.gz C229764-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C229764-TP C229764-TP_1.fastq.gz C229764-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C231855-TR1 C231855-TR1_1.fastq.gz C231855-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C231855-TP C231855-TP_1.fastq.gz C231855-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C234192-TR1 C234192-TR1_1.fastq.gz C234192-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C234192-TR2 C234192-TR2_1.fastq.gz C234192-TR2_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C234192-TP C234192-TP_1.fastq.gz C234192-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C2415597-TP C2415597-TP_1.fastq.gz C2415597-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C243048-TR1 C243048-TR1_1.fastq.gz C243048-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C243048-TP C243048-TP_1.fastq.gz C243048-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C243909-TR1 C243909-TR1_1.fastq.gz C243909-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C243909-TP C243909-TP_1.fastq.gz C243909-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C247230-TR1 C247230-TR1_1.fastq.gz C247230-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C247230-TP C247230-TP_1.fastq.gz C247230-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C259161-TR1 C259161-TR1_1.fastq.gz C259161-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C259161-TP C259161-TP_1.fastq.gz C259161-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C266664-TP C266664-TP_1.fastq.gz C266664-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C283515-TR1 C283515-TR1_1.fastq.gz C283515-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C283515-TP C283515-TP_1.fastq.gz C283515-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C287328-TR1 C287328-TR1_1.fastq.gz C287328-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C287328-TP C287328-TP_1.fastq.gz C287328-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C289419-TP C289419-TP_1.fastq.gz C289419-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C298152-TR1 C298152-TR1_1.fastq.gz C298152-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C298152-TP C298152-TP_1.fastq.gz C298152-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C330255-TR1 C330255-TR1_1.fastq.gz C330255-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C383391-TR1 C383391-TR1_1.fastq.gz C383391-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C383391-TR2 C383391-TR2_1.fastq.gz C383391-TR2_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C383391-TP C383391-TP_1.fastq.gz C383391-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3L-04081-TP C3L-04081-TP_1.fastq.gz C3L-04081-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3L-05481-TP C3L-05481-TP_1.fastq.gz C3L-05481-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3L-06625-TP C3L-06625-TP_1.fastq.gz C3L-06625-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3L-07202-TP C3L-07202-TP_1.fastq.gz C3L-07202-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3L-07213-TP C3L-07213-TP_1.fastq.gz C3L-07213-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3L-07611-TP C3L-07611-TP_1.fastq.gz C3L-07611-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-01191-NAT C3N-01191-NAT_1.fastq.gz C3N-01191-NAT_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-01197-NAT C3N-01197-NAT_1.fastq.gz C3N-01197-NAT_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-01365-NAT C3N-01365-NAT_1.fastq.gz C3N-01365-NAT_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-02684-NAT C3N-02684-NAT_1.fastq.gz C3N-02684-NAT_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-03026-NAT C3N-03026-NAT_1.fastq.gz C3N-03026-NAT_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-03446-NAT C3N-03446-NAT_1.fastq.gz C3N-03446-NAT_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-03450-NAT C3N-03450-NAT_1.fastq.gz C3N-03450-NAT_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-03452-NAT C3N-03452-NAT_1.fastq.gz C3N-03452-NAT_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-04113-TP C3N-04113-TP_1.fastq.gz C3N-04113-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C3N-05991-TP C3N-05991-TP_1.fastq.gz C3N-05991-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C464694-TP C464694-TP_1.fastq.gz C464694-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C524103-TR1 C524103-TR1_1.fastq.gz C524103-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C524103-TP C524103-TP_1.fastq.gz C524103-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C621273-TR1 C621273-TR1_1.fastq.gz C621273-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C685110-TR1 C685110-TR1_1.fastq.gz C685110-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C685110-TP C685110-TP_1.fastq.gz C685110-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C760878-TR1 C760878-TR1_1.fastq.gz C760878-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C760878-TP C760878-TP_1.fastq.gz C760878-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C761370-TR1 C761370-TR1_1.fastq.gz C761370-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C761370-TP C761370-TP_1.fastq.gz C761370-TP_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C827913-TR2 C827913-TR2_1.fastq.gz C827913-TR2_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C846363-TR1 C846363-TR1_1.fastq.gz C846363-TR1_2.fastq.gz 10
bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh C846363-TP C846363-TP_1.fastq.gz C846363-TP_2.fastq.gz 10

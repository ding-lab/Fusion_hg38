#!/usr/bin/python
# usage: makeDir_v3.1_CPTAC.py GBM_2022_02_11_fusion.tsv

import sys;
import subprocess;

outputFolder = sys.argv[2];

# Sample name is the first/only column in samples.txt
wantedFile = open(sys.argv[1]);
#wanted = [line.strip() for line in wantedFile];
wanted = [line.strip()[2] for line in wantedFile];
#print (wanted)
wantedFile.close();

# FileMap file
outputa = open("toRun.sh","w");
outputb = open("Batch_toRun.sh","w");
output = open("toRun_tmux.sh","w");
output2= open("samples_missing.txt","w");
matchFile = open(sys.argv[1])
matchFile.readline();
for line in matchFile:
	line = line.strip().split("\t");
	#use column 3 tumor_name as folder names
	sample = line[2];
	R1path=line[5];
	R2path=line[6];
	#print (sample);
	if sample not in sample:
		print(sample+"\t"+"noData",file=output2);
		continue;
	subprocess.call("mkdir "+outputFolder+"/"+sample,shell=True);
	subprocess.call("ln -s "+R1path+" "+outputFolder+"/"+sample+"/"+sample+"_1.fastq.gz",shell=True);
	subprocess.call("ln -s "+R2path+" "+outputFolder+"/"+sample+"/"+sample+"_2.fastq.gz",shell=True);
	print("bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh "+sample+" "+sample+"_1.fastq.gz "+sample+"_2.fastq.gz 10",file=outputa);
	print("tmux new -d -s "+ sample +" '"+ "bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh "+sample+" "+sample+"_1.fastq.gz "+sample+"_2.fastq.gz 10" +"'",file=output);
	print("batchfusion 'bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh "+sample+" "+sample+"_1.fastq.gz "+sample+"_2.fastq.gz 10'",file=outputb);
outputa.close();
outputb.close();
output.close();
output2.close();
matchFile.close();
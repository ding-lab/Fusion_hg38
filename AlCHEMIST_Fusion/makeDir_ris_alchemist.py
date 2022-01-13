#!/usr/bin/python
# usage: makeDir_v3.py samples.txt Alchemist.RNAMap.storage1.tsv

import sys;
import subprocess;

outputFolder = sys.argv[3];

# Sample name is the first/only column in samples.txt
wantedFile = open(sys.argv[1]);
wanted = [line.strip() for line in wantedFile];
#print (wanted)
wantedFile.close();

pathDict = {};
# FileMap file
matchFile = open(sys.argv[2])
matchFile.readline();
for line in matchFile:
	line = line.strip().split("\t");
	sample = line[0].split(".")[0];
	#print (sample);
	if sample not in wanted:
		continue;
	if "tumor" in line[4]:
		tissue = "T";
	elif "FFPE Scrolls" in line[4]:
		tissue = "FS";
	elif "FFPE Recurrent" in line[4]:
		tissue = "R";
	elif "Metastatic" in line[4]:
		tissue = "M";
	else:
		tissue = "S";
	pairDir = line[0].split(".")[-2];
	path = line[5];
	if "fastq" not in path:
		continue;
	if sample not in pathDict:
		#pathDict[sample] = {"T":{"R1":"","R2":""},"FS":{"R1":"","R2":""},"R":{"R1":"","R2":""},"M":{"R1":"","R2":""},"S":{"R1":"","R2":""}};
		pathDict[sample] = {"R1":"","R2":""};
		#print (pathDict);
	pathDict[sample][pairDir] = path;
matchFile.close();

outputa = open("toRun.sh","w");
output = open("toRun_tmux.sh","w");
output2 = open("missingsamples.txt","w");

for sample in pathDict:
	if sample not in wanted:
		print(sample+"\t"+"noData",file=output2);
		continue;
	subprocess.call("mkdir "+outputFolder+"/"+sample,shell=True);
	subprocess.call("ln -s "+pathDict[sample]["R1"]+" "+outputFolder+"/"+sample+"/"+sample+"_1.fastq.gz",shell=True);
	subprocess.call("ln -s "+pathDict[sample]["R2"]+" "+outputFolder+"/"+sample+"/"+sample+"_2.fastq.gz",shell=True);
	print("bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh "+sample+" "+sample+"_1.fastq.gz "+sample+"_2.fastq.gz 10",file=outputa);
	print("tmux new -d -s "+ sample +" '"+ "bash /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_pipeline/Fusion/Fusion_hg38_scripts/fusion_pipeline_ris_v1.sh "+sample+" "+sample+"_1.fastq.gz "+sample+"_2.fastq.gz 10" +"'",file=output);
outputa.close();
output.close();
output2.close();

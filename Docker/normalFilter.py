#!/usr/bin/python

import sys;
import subprocess;

cmd = subprocess.Popen('ls', stdout=subprocess.PIPE);
cmd_out, cmd_err = cmd.communicate();
cmd_out = cmd_out.decode(sys.stdout.encoding).split("\n");
for i in cmd_out:
	normalFusions = [];
	if "_N" in i:
		sample = i[:-2];
		normalFile = open(sample+"_N/Merged_Fusions/Filtered_Fusions_in_"+sample+"_N.tsv");
		normalFile.readline();
		for line in normalFile:
			line = line.strip().split("\t");
			normalFusions.append(line[0]);
		normalFile.close();
		output = open(sample+"_T/Merged_Fusions/Normal_Filtered_Fusions_in_"+sample+"_T.tsv","w");
		tumorFile = open(sample+"_T/Merged_Fusions/Filtered_Fusions_in_"+sample+"_T.tsv");
		print(tumorFile.readline().strip(),file=output);
		for line in tumorFile:
			data = line.strip().split("\t");
			if data[0] not in normalFusions:
				print(line.strip(),file=output);
		tumorFile.close();
		output.close();
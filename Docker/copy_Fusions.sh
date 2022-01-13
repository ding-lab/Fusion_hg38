#!/bin/bash

dir=$1
target=$2

ls $dir | grep _T | while read sample
do
        cp $dir/$sample/Merged_Fusions/Normal_Filtered_Fusions_in_${sample}.tsv $2/${sample::-2}.Fusions.txt
        #awk -v x=${sample} '{print $0, x}' $dir/$sample/${sample}_somatic > $2/${sample}.sites.tsv
done

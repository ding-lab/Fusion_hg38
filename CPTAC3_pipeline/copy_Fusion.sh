#!/bin/bash

dir=$1
target=$2

ls $dir | grep 'C' | while read sample
do
        cp $dir/$sample/Merged_Fusions/Filtered_Fusions_in_${sample}.tsv $2/${sample}.Fusions.txt
done

#!/usr/bin/env sh
set -e

#variables
input=$1
output=${2:-results/gene_summary.tsv}
config=${CONFIG_FILE:-scripts/config.sh}

# Set the wd or smth
source $config
mkdir -p $(dirname $output)
ln -s $input data/latest.tsv

#Functions
gene_count=$(grep -c "GENE" $input) #This just works
high_expression=$(awk -F ',' '$9 > 100' $input | wc -l)

echo "file,genes,high_expression" > $output
echo "$input,$gene_count,$high_expression" >> $output
echo "Finished"

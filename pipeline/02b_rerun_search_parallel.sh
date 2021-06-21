#!/usr/bin/bash
#SBATCH --ntasks 48 --mem 64G --time 2:00:00 -p short -N 1 --out logs/phyling_parallel.log -C xeon
module unload perl
module unload python
module load parallel
module load hmmer/3
module unload miniconda2
module load miniconda3
if [ ! -f config.txt ]; then
	echo "Need config.txt for PHYling"
	exit
fi

source config.txt
if [ ! -z $PREFIX ]; then
	rm -rf aln/$PREFIX
fi
# probably should check to see if allseq is newer than newest file in the folder?
echo " I will remove prefix.tab to make sure it is regenerated"
./PHYling_unified/PHYling search -q parallel

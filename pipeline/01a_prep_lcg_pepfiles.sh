#!/usr/bin/bash -l
#SBATCH -p short -N 1 -n 1 --mem 2gb --out logs/prep_pepfiles.log

#SAMPLES=lib/samples_prefix.csv
SAMPLES=lib/samples.dat
EXT=predict_results/*.proteins.fa
# these are preferred new annotations
DIR=../LCG/Annotation/annotate
TARGET=pep
mkdir -p $TARGET
grep -v -P 'Chytridiomycota|Blastocladiomycota' $SAMPLES | while read SPECIES PHYLUM SUBPHYLUM
do
    if [ ! -s $TARGET/$SPECIES.LCG.aa.fasta ]; then
	infile=$(ls $DIR/$SPECIES/$EXT)
	if [ ! -z $infile ]; then
	    echo "generating $TARGET/$SPECIES.LCG.aa.fasta"
	    perl -p -e 's/>([^_]+)/>$1|$1/' $infile > $TARGET/$SPECIES.LCG.aa.fasta
	fi
    else
	echo "already created $TARGET/$SPECIES.LCG.aa.fasta - skipping"
    fi
done 

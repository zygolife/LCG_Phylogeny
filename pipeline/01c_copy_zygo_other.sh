#!/usr/bin/bash -l
#SBATCH -p short

TARGETDIR=pep
mkdir -p $TARGETDIR

rsync -aL ../datasets/genomes/pep/*.aa.fasta $TARGETDIR/

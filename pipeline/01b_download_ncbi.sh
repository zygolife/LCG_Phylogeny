#!/usr/bin/bash -l
#SBATCH -p short

ACCFILE=lib/NCBI_accessions.csv
URLBASE=https://ftp.ncbi.nlm.nih.gov/genomes/all
TARGETDIR=pep
TEMPDIR=NCBI
mkdir -p $TEMPDIR $TARGETDIR
IFS=,
cat $ACCFILE | grep saturninu | while read SPECIES STRAIN ACCESSION
do
    STEM=$(echo -n "$SPECIES $STRAIN" | perl -p -e 's/\s+/_/g')
    
    PRE=$(echo $ACCESSION | cut -d_ -f1 )
    ONE=$(echo $ACCESSION | cut -d_ -f2 | awk '{print substr($1,1,3)}')
    TWO=$(echo $ACCESSION | cut -d_ -f2 | awk '{print substr($1,4,3)}')
    THREE=$(echo $ACCESSION | cut -d_ -f2 | awk '{print substr($1,7,3)}')
    echo "$PRE/$ONE/$TWO/$THREE/$ACCESSION/${ACCESSION}_translated_cds.faa.gz"
    curl -o $TEMPDIR/$STEM.aa.fasta.gz $URLBASE/$PRE/$ONE/$TWO/$THREE/$ACCESSION/${ACCESSION}_translated_cds.faa.gz
    pigz -dc $TEMPDIR/$STEM.aa.fasta.gz | perl -p -e 'if ( ! s/>lcl\|(\S+)\s+.*\[locus_tag=(([^_]+)_([^\]]+))\]/>$3|$2 $1/ ) { s/^\-// }' > $TARGETDIR/$STEM.aa.fasta
done

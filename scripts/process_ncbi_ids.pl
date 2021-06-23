#!/usr/bin/env perl
use strict;
use warnings;

my %seen;

while(<>) {
    # replace locus tag
    if ( s/>lcl\|(\S+)\s+.*\[locus_tag=(([^_]+)_([^\]]+))\]/>$3|$2 $1/ ) { 
	if ( $seen{$2}++ > 1 ) {
	    $_ = sprintf(">%s.%d %s",$2,$seen{$2},$1)
	} 
    } else {
	s/^\-//; # deal with mis-specified partial genes for proteins
    }
    print $_;
}

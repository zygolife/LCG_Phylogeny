#!/usr/bin/env perl
use strict;
use warnings;

my %seen;

while(<>) {
    # replace locus tag
    if ( s/>lcl\|(\S+)\s+.*\[locus_tag=(([^_]+)_([^\]]+))\]\s+(.+)/>$3|$2 $1/ ) { 
	my $pref = $3;
	my $id = $2;
	my $longname = $1;
	$seen{$id}++;
	if ( $seen{$id} > 1 ) {
	    $_ = sprintf(">%s|%s.%d %s\n",$pref,$id,$seen{$id},$longname);
	} 
    } else {
	s/^\-//; # deal with mis-specified partial genes for proteins
    }
    print $_;
}

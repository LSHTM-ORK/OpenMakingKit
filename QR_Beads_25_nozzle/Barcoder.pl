#!/usr/local/bin/perl

use Barcode::DataMatrix;
$, = '--';
my $data = Barcode::DataMatrix->new->barcode($ARGV[0]);
for my $row (@$data) {
			          print for map { $_ ? "1" : '0' } @$row;
			          print "\n";
        			  } 

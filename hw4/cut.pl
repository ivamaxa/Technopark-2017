#!/usr/bin/env perl
use 5.016;
use warnings;
use Getopt::Long;

my (@f_key, $d_key, $s_key);
GetOptions ('f=f{,}' => \ @f_key, 'd=s' => \$d_key, 's' => \$s_key);

my @word;
my $del;
$del = defined $d_key ?  $d_key : "\t"; 
my $regexp=qr/$del/;

my %hash;
@f_key = sort (grep !$hash{$_}++, @f_key);

my @index;
foreach (@f_key) {
	my $ind=$_-1;
	push @index, $ind;
}
#внутри единственного цикла по строкам, единственный цикл по столбцам внутри которого будет регулярка??
while(<STDIN>){	
	@word = split (/$del/, $_);
	if (defined $s_key) {
		if ($_=~$regexp) { 
			foreach(@index) { 
				print "$word[$_]  " if defined $word[$_];	
			}
		}
	}
	else {
		if ($_!~$del) {
			print $_;
		}
		else {
			foreach(@index) {
				if (defined $word[$_]) {
					print "$word[$_]";
					print $del if $word[$_]!=$word[-1];  
				}
			}
		}
	}
	print "\n";
}

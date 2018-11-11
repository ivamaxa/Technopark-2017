#!/usr/bin/perl
use 5.016;
use warnings;
use Getopt::Long qw(:config no_ignore_case);
Getopt::Long::Configure("bundling_values");

my ( $c_key, $i_key, $v_key, $F_key, $n_key);
my ($A_key, $B_key, $C_key);
GetOptions (
			'A=s' => \ $A_key,
    		'B=s' => \ $B_key , 
    		'C=s' => \ $C_key, 
    		'c'   => \ $c_key, 
    		'i'   => \ $i_key, 
    		'v'   => \ $v_key,
    		'F'   => \ $F_key, 
    		'n'   => \ $n_key
    		);
my @arr;
my @arr_num;
my @el;
my $arg=0;
my $output; 
my $prev = 0; 
my $t;
my $el_after;
my $el_before;
my $k = 0;
if (defined $A_key) {
	$el_after=$A_key;
	if (defined $B_key) {
		$el_before=$B_key;	
	}
	elsif (defined $C_key) {
		$el_before=$C_key;
	}
}
elsif (defined $C_key) {
	$el_after=$C_key;
	if (defined $B_key) {
		$el_before=$B_key;
	}
	else {
		$el_before=$C_key;
	}	 
}
elsif (defined $B_key) {
	$el_before=$B_key;
}

sub print_str {
	my ($el, $num) = @_;
	defined $n_key ? print "$num\:$el" : print $el;
}
if (defined $ARGV[0]) {
	my $regexp = 	defined $i_key ? qr/$ARGV[0]/i :
					defined $F_key ? qr/$ARGV[0]/:
					qr/$ARGV[0]/;

while (<STDIN>) {
	if ( defined $c_key ) {
		$k++ if ( defined $v_key ? $_!~$regexp : $_=~$regexp );
	}
	elsif ( !defined $A_key && !defined $B_key && !defined $C_key ) {
		print_str ($_, $.) if ( defined $v_key ? $_!~$regexp : $_=~$regexp  );
	} 
	else {
		if (defined $v_key) {
			if ($_!=$arg) {
				$t=0;
				print_str($_,$.) if $_!~$regexp;
			}
		 	else {
		 		#$el_after--;
		 		if (defined $el_after && $el_after>0) {
		 			
					print_str($_, $.) ;
					$el_after--;
				}			
				
				print "--\n" if $t == 0;	
				$t++;
		 		if (defined $el_before && $el_before>0) {
		 			print_str($_,$.);
		 			$el_before--;
	 			}
			}
		}
		else {
			if ( $_=~$regexp  ) {
				if ( scalar @arr > 0 ) {
					print "--\n" if ( $prev && $arr_num[0] - $prev > 1 );
					for ( 0..$#arr ) {
						print_str ($arr[$_], $arr_num[$_]);
					}
				} 
				else {
					print "--\n" if ( $prev && $. - $prev > 1 );
				} 
			print_str ($_, $.); 
			$prev = $.;
			$output = $el_after; 
			@arr = ();
			@arr_num = ();
			}
			elsif ( $output ) {
				print_str ($_, $.);
				$prev = $.;
				$output--;
			}
			elsif ( $el_before ) {
				if ( scalar @arr < $el_before ) {
					push @arr, $_;
					push @arr_num, $.;
				} 
				else {
					shift @arr;    	
					shift @arr_num;	
					push @arr, $_;
					push @arr_num, $.;
				}
			}
		}
	}
		$arg = $_;
}

say $k if defined $c_key;

}
else {
	die "Введите шаблон для поиска";
}
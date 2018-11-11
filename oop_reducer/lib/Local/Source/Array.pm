package Local::Source::Array;

use strict;
use warnings;
use parent qw(Local::Source);


sub next {
	my $self=shift;

	return $self->{array}[$self->{iterator}++]; 
	
}

1;
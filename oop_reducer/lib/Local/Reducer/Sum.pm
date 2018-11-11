package Local::Reducer::Sum; 

use strict;
use warnings;
use parent qw(Local::Reducer);


sub move {
	my $self = shift;
	my $row_object = shift;
	$row_object =$row_object->get($self->{field});
	if ($row_object =~/^\d+(?:[,.]\d+)?$/ )  {
		$self->{initial_value}+=$row_object;
	}

	return $self -> reduced;
}

1;
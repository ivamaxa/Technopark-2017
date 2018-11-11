package Local::Reducer::MaxDiff; 

use strict;
use warnings;

use parent qw(Local::Reducer);
sub move {
	my $self=shift;
	my $row_object = shift;
	my $row_object1=$row_object->get($self->{top});
	my $row_object2=$row_object->get($self->{bottom});
	if ($row_object1 =~/^\d+(?:[,.]\d+)?$/ && $row_object2 =~/^\d+(?:[,.]\d+)?$/) {
		my $res=abs($row_object1-$row_object2);
		$res > $self->{initial_value} ? $self->{initial_value}=$res : $self->reduced ;
	} 
}



1;
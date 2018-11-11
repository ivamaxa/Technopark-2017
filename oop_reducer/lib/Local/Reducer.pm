package Local::Reducer;

use strict;
use warnings;

=encoding utf8

=head1 NAME

Local::Reducer - base abstract reducer

=head1 VERSION

Version 1.00
 
=cut
 
our $VERSION = '1.00';
 
=head1 SYNOPSIS
 
=cut


sub new  {
	my ($class, %params) =@_;
	return bless \%params, $class;
}
sub reduce_n {
	my ($self, $n) = @_;
	my $i=0;
	while (defined $n ? $i<$n : 1) {

		my $some_string = $self->{source}->next or last ;
		my $row_object = $self->{row_class}->new(str => $some_string);
		if ( $row_object) { 
			$self->move($row_object);
		}
		$i++;
	}

	return $self -> reduced;
}

sub reduce_all {
	my ($self) = @_;
	return $self->reduce_n;
}

sub reduced {
	my ($self) = @_;
	return $self->{initial_value};
}


1;

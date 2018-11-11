package Local::Source::Text;

use strict;
use warnings;
use parent qw(Local::Source::Array);

sub new {
	
	my ($class, %params) = @_;
	return $class -> SUPER::new (array => [split(defined $params{delimiter} ? $params{delimiter} : '\n', $params{text})]);
	

}

1;
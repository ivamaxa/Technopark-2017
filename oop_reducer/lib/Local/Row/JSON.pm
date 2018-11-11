package Local::Row::JSON;

use strict;
use warnings;
use JSON::XS;

use parent qw(Local::Row);

#концепция раннего возврата из функции один супер
sub new {
	
	my ($class, %params) = @_;
	my %hash; 
	return if $params{str} eq '';	
	eval {
		%hash = %{ decode_json ($params{str}) }; 
	};

	return $class -> SUPER::new (%hash) unless $@;
	return undef;
	


}

1;
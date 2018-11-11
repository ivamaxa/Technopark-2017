package Local::Row::Simple;

use strict;
use warnings;
use parent qw(Local::Row);

sub new {
#1й параметр строка с именем пакета
	my ($class, %params) = @_;
	my $flag = undef;
	my %hash;
	if ($params{str} =~ /^([\w]+:[\w]+(,[\w]+:[\w]+)*)$/) {
		%hash = split /[\:\,]/, $params{str};
		$flag++;
	}
	elsif ($params{str} eq  '') {
		$flag++;
	}
	
	return $class -> SUPER::new (%hash) if $flag;
	return undef;
	

	
}



1;
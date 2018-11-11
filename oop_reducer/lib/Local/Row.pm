package Local::Row; 
#парсинг данных
use strict;
use warnings;


sub new 
{
	#1й параметр строка с именем пакета
	my ($class, %params) = @_; 

	return bless \%params, $class;
}

sub get
{
	my ($self) = shift;
	my ($name, $default) = @_; 

	return defined $self -> {$name} ? $self -> {$name} : $default; 
}

1;
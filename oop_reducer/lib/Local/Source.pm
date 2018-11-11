package Local::Source; 
#подача  данных в Reducer
use strict;
use warnings;

my ($class,%params);
$params{iterator}=0;

sub new  {
	($class, %params) = @_;
	return bless \%params, $class;
}



1;
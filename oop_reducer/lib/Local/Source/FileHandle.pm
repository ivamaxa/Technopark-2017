package Local::Source::FileHandle; 
#подача  данных в Reducer
use strict;
use warnings;

use parent qw(Local::Source);

 sub next {
 	 my $self=shift;
 	 my $line=readline $self->{fh};
 	 chomp $line if($line);
 	 return $line;

 }

1;
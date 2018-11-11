#!/usr/bin/env perl 
use 5.016;
use warnings;
use IO::Socket;
use Getopt::Long;


my ($u, $port, $host);
GetOptions ( 'u' => \$u );
die "Not enough arguments" if @ARGV < 2;
($host, $port) = @ARGV;

my $socket = IO::Socket::INET->new (
Proto => ($u) ? "udp" : "tcp",	
PeerAddr => $host,
PeerPort => $port,
)
or die "Can't connect: $! \n";

while (<STDIN>) {
	print $socket $_;
	print scalar <$socket>;

}
close $socket || die "Can not close connection...\n"; 


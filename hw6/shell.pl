#!/usr/bin/env perl 
use 5.016;
use warnings;
use Getopt::Long;
use Cwd;
my $cmd;


sub pwd {
	return getcwd();
}
sub cd {
	$cmd=~s/cd//;
	if($cmd) {
		$cmd=~ s/~/$ENV{HOME}/;
	}
	else {
		chdir $ENV{HOME};
	}
}
sub echo {
 	$cmd=~s/echo//;
	return $cmd;
}
sub sub_kill {
	$cmd=~s/KILL//;
	kill 'KILL', $cmd;
}
my @mas;
my @res;
my $a;
my @word;
say "Hello!";
while(1) {
	say "\nEnter the commands:)";
	print ">";
	chomp($a=<>);
	@word=split(/\|/, $a);
	
	#если всего одна команда
	unless($#word) {
		$cmd=shift @word;
		if ($cmd) {
			say $cmd=~/^echo\s+/ ? echo :
			$cmd=~/^cd/ ? cd :
			$cmd=~/^pwd$/ ? pwd :
			$cmd=~/^kill$/ ? sub_kill :
			exec "$cmd" ;

		}
	}
	else {
		if (my $pid=open(CHILDHANDLE, '-|'))	{
			print $_ while (<CHILDHANDLE>);
			close (CHILDHANDLE);
			waitpid($pid , 0);
		}
		else {
			die "Cannot fork: $!" unless defined $pid;
			my @cmd_stdout; #вывод команд
			for my $i(0 .. $#word) {
				my $cmd=$word[$i];
				pipe (FROM_P, IN_C); #из родительского в дочерний
				pipe (FROM_C, IN_P); #из дочернего в родительский
				if (my $pidd = fork()) {
					#родительский процесс
					if ($i!=0) {
						close(FROM_P);
						print IN_C @cmd_stdout;
						close (IN_C);
						@cmd_stdout = ();
					}
					close (IN_P);
					while(<FROM_C>) {
						push @cmd_stdout, $_;

					}
					close (FROM_C);
					waitpid($pidd , 0);
				}
				else {
					die "Cannot fork: $!" unless defined $pidd;
					#дочерний
					open(STDERR, '>&', 'STDOUT');
					if ($i) {
						close(IN_C);
						open(STDIN, '<&', 'FROM_P');
						close (FROM_P);
					}
					close(FROM_C);
					open(STDOUT, '>&', 'IN_P') or die $!;
					close(IN_P);
					if ($cmd=~/echo|pwd|cd|kill/) {
						say $cmd=~/^echo\s+/ ? echo :
						$cmd=~/^cd$/ ? cd :
						$cmd=~/^pwd$/ ? pwd :
						 kill ;


					}
					else {
						exec "$cmd" or exit;
					}

				}


		}			
		print @cmd_stdout;
		exit;	
		}
	}
	

	
}
package Psh::Strategy::Bang;

require Psh::Strategy;

use strict;
use vars(@ISA);


@ISA=('Psh::Strategy');

sub consumes {
	return Psh::Strategy::CONSUME_LINE;
}

sub runs_before {
	return qw(brace);
}

sub applies {
	return 'pass to sh' if substr($$_[1],0,1) eq '!';
}

sub execute {
	my $command= substr($$_[1],1);

	my $fgflag = 1;
	if ($call =~ /^(.*)\&\s*$/) {
		$call= $1;
		$fgflag=0;
	}

	Psh::OS::fork_process( $call, $fgflag, $call, 1);
	return undef;
}

1;
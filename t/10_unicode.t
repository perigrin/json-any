#!perl
$|++;
use strict;
use utf8;
use Test::More 'no_plan';

use JSON::Any;

foreach my $backend qw(XS JSON DWIW Syck) {
	my $j = eval {
		JSON::Any->import($backend);
		JSON::Any->new( utf8 => 1 );
	} || next;

	$j->handler or next;

	diag "handler is " . ref($j->handler);

	foreach my $text qw(foo שלום) {

		my $struct = [ $text ];

		my $frozen = $j->encode( $struct );
		my $thawed = $j->decode( $frozen );

		is_deeply( $thawed, $struct, "deeply" );

		is( $thawed->[0], $text, "text is the same" ) || eval {
			require Devel::StringInfo;
			my $d = Devel::StringInfo->new;
			$d->dump_info( $text, name => "expected" );
			$d->dump_info( $thawed->[0], name => "got" );
			$d->dump_info( $frozen );
		};

		is( !!utf8::is_utf8($thawed->[0]), !!scalar($text !~ /[a-z]/), "text is utf8 if input was" );
	}
}


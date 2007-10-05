#!perl
$|++;
use strict;
use utf8;
use Test::More 'no_plan';

use JSON::Any;

$ENV{JSON_ANY_CONFIG} = "utf8=1";

foreach my $backend qw(XS JSON DWIW Syck PC) {
    my $j = eval {
        JSON::Any->import($backend);
        JSON::Any->new;
    };

    diag $@ and next if $@;

    $j and $j->handler or next;

    diag "handler is " . (ref($j->handler) || $j->handlerType);

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

        ok( utf8::is_utf8($thawed->[0]) || !scalar($text !~ /[a-z]/), "text is utf8 if it needs to be" );

        if ( utf8::valid($frozen) ) { 
            utf8::decode($frozen);

            my $thawed = $j->decode( $frozen );

            is_deeply( $thawed, $struct, "deeply" );

            is( $thawed->[0], $text, "text is the same" ) || eval {
                require Devel::StringInfo;
                my $d = Devel::StringInfo->new;
                $d->dump_info( $text, name => "expected" );
                $d->dump_info( $thawed->[0], name => "got" );
                $d->dump_info( $frozen );
            };

            ok( utf8::is_utf8($thawed->[0]) || !scalar($text !~ /[a-z]/), "text is utf8 if it needs to be" );
        }
    }
}


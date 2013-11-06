#!perl
$!++;
use strict;
use Data::Dumper;
use Test::More;

use Storable;
use Test::Requires qw(JSON::Any);

$Data::Dumper::Indent = 0;
$Data::Dumper::Terse  = 1;

my @round_trip = (
    '"\""',
    '"\b"',
    '"\f"',
    '"\n"',
    '"\r"',
    '"\t"',
    '"\u0001"',
);

# Seems most handlers decode the escaped slash (solidus), but don't
# encode it escaped.  TODO: What does the spec *really* say?
# For now, just test decoding.  Improper decoding breaks things.
my %one_way = (
    '"\/"' => '/',  # escaped solidus
);

{
    test('XS');
}

{
    require Test::Without::Module;
    Test::Without::Module->import('JSON::XS');
    test ($_) for qw(PP JSON CPANEL DWIW);
}

sub test {
    my ($backend) = @_;
    my $j = eval {
        JSON::Any->import($backend);
        JSON::Any->new;
    };

    note "$backend: " . $@ and next if $@;

    $j and $j->handler or next;

    note "handler is " . ( ref( $j->handler ) || $j->handlerType );

    plan 'no_plan' unless $ENV{JSON_ANY_RAN_TESTS};
    $ENV{JSON_ANY_RAN_TESTS} = 1;
    
    for my $test_orig ( @round_trip ) {
        my $test = "[$test_orig]"; # make it an array
        my $data = eval { JSON::Any->jsonToObj($test) };
        my $json = JSON::Any->objToJson($data);

        # don't bother white spaces
        for ($test, $json) {
            s/([,:]) /$1/eg;
        }

        my $desc = "roundtrip $test -> " . Dumper($data) . " -> $json";
        utf8::encode($desc);
        is $json, $test, $desc;

    }

    while ( my ($encoded, $expected) = each %one_way ) {
        my $test = "[$encoded]";
        my $data = eval { JSON::Any->jsonToObj($test) };

        my $desc = "oneway $test -> " . Dumper($data);
        utf8::encode($desc);
        is $data->[0], $expected, $desc;
    }
}

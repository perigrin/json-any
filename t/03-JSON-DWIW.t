#!perl -T
use strict;
use Test::More tests => 3;

BEGIN {
    use_ok('JSON::Any');
}

SKIP: {
    eval { JSON::Any->import(qw(DWIW)) };
    skip "JSON::DWIW not installed: $@", 1 if $@;
    diag("Testing JSON::DWIW backend");
    my ( $json, $js, $obj );

    # encoding bare keys
    ok( $json = JSON::Any->new( bare_keys => 1 ) );
    $js = $json->to_json({ var1 => "val2" });
    is( $js, '{var1:"val2"}' );
}


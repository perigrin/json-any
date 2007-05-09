#!perl -T
$|++;
use strict;
use Test::More tests => 5;
use JSON::Any;

SKIP: {
    eval { JSON::Any->import(qw(PC JSON)) };
    skip "Neither JSON::PC nor JSON installed: $@", 3 if $@;
    diag("Testing JSON/JSON::PC backend");
    my ( $js, $obj );

    #1
    ok( my $json = JSON::Any->new( autoconv => 1 ) );
    $obj = { "id" => JSON::Number("1.02") };
    {
        local $JSON::AUTOCONVERT = 0;
        my $js = $json->objToJson($obj);

        #2
        is( $js, '{"id":1.02}' );
    }
    $js = $json->objToJson($obj);

    #3
    is( $js, '{"id":1.02}' );

    $obj = { "id" => '0xfa' };
    $js = $json->objToJson($obj);

    #4
    is( $js, '{"id":0xfa}' );

    #5
    ok( $json = JSON::Any->new( pretty => 1 ) );

}

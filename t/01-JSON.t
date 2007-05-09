#!perl -T
$|++;
use strict;
use Test::More;

eval "use JSON::Any qw(PC JSON)";
if ($@) {
    plan skip_all => "Neither JSON::PC nor JSON installed: $@";
}
{
    plan => 5;
}

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


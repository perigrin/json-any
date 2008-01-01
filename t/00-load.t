#!perl -T

use Test::More;

BEGIN {
    eval "use JSON::Any";

    if ($@) {
        plan skip_all => "$@";
        exit;
    }
    else {
        plan tests => 7;
    }
}
pass('use JSON::Any;');
diag("Testing JSON::Any $JSON::Any::VERSION, Perl $], $^X");
can_ok( JSON::Any, qw(new) );
can_ok( JSON::Any, qw(objToJson jsonToObj) );
can_ok( JSON::Any, qw(to_json from_json ) );
can_ok( JSON::Any, qw(Dump Load ) );
can_ok( JSON::Any, qw(encode decode ) );

is( JSON::Any->objToJson( { foo => 'bar' } ), q[{"foo":"bar"}] );

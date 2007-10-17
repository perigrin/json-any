#!/usr/bin/perl -w

use strict;
use Test::More tests => 2;
use JSON::Any qw(Syck);

ok( JSON::Any->new->objToJson( { foo => 1 } ) );
ok( JSON::Any->new->objToJson('{ "foo" : 1 }') );

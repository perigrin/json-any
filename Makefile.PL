use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'JSON::Any',
    AUTHOR              => 'Chris Thompson <cthom@cpan.org>',
    VERSION_FROM        => 'lib/JSON/Any.pm',
    ABSTRACT_FROM       => 'lib/JSON/Any.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'JSON-Any-*' },
);

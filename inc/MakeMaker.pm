package inc::MakeMaker;
use Moose;
extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

use namespace::autoclean;

override _build_WriteMakefile_dump => sub {
    my ($self) = @_;

    my $str = super;

    $str .= ";\n\n";

    $str .= <<'END_NONSENSE';
  
    sub has_json () {
        our @order = qw(CPANEL XS PP JSON DWIW);
        foreach my $testmod (@order) {
            $testmod = "JSON::$testmod" unless $testmod eq "JSON";
            $testmod = "Cpanel::JSON::XS" if $testmod eq "JSON::CPANEL";
            eval "require $testmod";
            return 1 unless $@;
        }
        return 0;
    }

    if (has_json) {
        # we have some kind of supported JSON module, we're good
    }
    else {

        # we need to have a version of JSON, go with JSON.pm as a sane default
        $WriteMakefileArgs{PREREQ_PM}{JSON} = '2.02';
    }
    
  
END_NONSENSE

    return $str;
};

1;

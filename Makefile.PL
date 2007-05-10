# Drop-in replacement to ExtUtils::MakeMaker
use inc::Module::Install;

# Define metadata
name 'JSON::Any';
all_from 'lib/JSON/Any.pm';

requires 'Carp' => '0';

feature 'JSON',
  -default => 1,
  'JSON'   => '0';

feature 'JSON::XS',
  -default   => 0,
  'JSON::XS' => '0';

feature 'JSON::PC',
  -default   => 0,
  'JSON::PC' => '0';

feature 'JSON::DWIW',
  -default     => 0,
  'JSON::DWIW' => '0';

feature 'JSON::Syck',
  -default     => 0,
  'JSON::Syck' => '0';

# Specific dependencies
build_requires 'Test::More' => '0';
no_index 'directory'        => 'ex';

auto_install;
WriteAll;

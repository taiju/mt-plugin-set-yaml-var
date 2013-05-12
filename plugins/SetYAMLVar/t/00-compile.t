use strict;
use warnings;
use lib 't/lib', 'lib', 'extlib';

use Test::More;

use MT;
use MT::Test;

ok(MT->component('SetYAMLVar'), 'plugin load ok');

require_ok('SetYAMLVar::Tags');

done_testing;

use strict;
use warnings;
use lib 't/lib', 'lib', 'extlib';

use Test::More;
use Test::Base;

use MT;
use MT::Test;
use MT::Template::Context;
use MT::Builder;

diag("YAML Module is $MT::Util::YAML::Module");

sub build {
  my $tmpl = shift;
  my $ctx = MT::Template::Context->new;
  my $builder = MT::Builder->new;
  my $tokens = $builder->compile($ctx, $tmpl) or die $builder->errstr;
  $builder->build($ctx, $tokens);
}


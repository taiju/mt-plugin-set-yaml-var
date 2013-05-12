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

sub build_var {
  my $tmpl = shift;
  my $ctx = MT::Template::Context->new;
  my $builder = MT::Builder->new;
  my $tokens = $builder->compile($ctx, $tmpl) or die $builder->errstr;
  $builder->build($ctx, $tokens);
  $ctx->stash('vars');
}

filters {
  input => [qw(build_var)],
  expected => [qw(eval)],
};

run_is_deeply input => 'expected';

done_testing;

__END__

=== hash variable
--- input
<mt:SetYAMLVar name="foo">
bar: 1
baz: 2
</mt:SetYAMLVar>

--- expected
{
  foo => {
    bar => 1,
    baz => 2,
  },
}

=== array variable
--- input
<mt:SetYAMLVar name="foo">
- 1
- 2
- 3
</mt:SetYAMLVar>

--- expected
{ foo => [1, 2, 3] }

=== multiple varables
--- input
<mt:SetYAMLVar>
foo: 1
bar: 2
baz: 3
</mt:SetYAMLVar>

--- expected
{
  foo => 1,
  bar => 2,
  baz => 3,
}

=== nested variables
--- input
<mt:SetYAMLVar>
foo:
  bar:
    baz:
      - 1
      - 2
      - 3
</mt:SetYAMLVar>

--- expected
{
  foo => {
    bar => {
      baz => [1, 2, 3],
    },
  },
}

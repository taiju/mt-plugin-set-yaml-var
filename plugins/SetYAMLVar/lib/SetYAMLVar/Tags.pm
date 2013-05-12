package SetYAMLVar::Tags;
use strict;
use warnings;

use Module::Load;

sub _hdlr_set_yaml_var {
    my ($ctx, $args, $cond) = @_;
    my $module = $MT::Util::YAML::Module;
    $module =~ s/^MT::Util:://;
    load $module, 'Load';
    my $tokens = $ctx->stash('tokens');
    my $builder = $ctx->stash('builder');
    my $out = $builder->build($ctx, $tokens, $cond);
    my $yaml = Load($out);
    my $name = $args->{name} || $args->{var};
    if ($name) {
      $ctx->var($name, $yaml);
      return '';
    }
    die "There is no key." if (ref $yaml eq 'ARRAY');
    $ctx->var($_, $yaml->{$_}) for keys(%$yaml);
    return '';
}

1;

=pod

=head2 SetYAMLVar

A block tag that is used creating any template variables with YAML format.

It is useful for creating a complex template variables, for example when creating a nested hash variables.

B<Attributes:>

=over 4

=item * var or name (optional)

Identifies the name of the template variable. See L<Var> for more information on the format of this attribute.

=back

B<Example1: Create multiple template variables.>

  <mt:SetYAMLVar>
  foo: 1
  bar: 2
  baz: 3
  </mt:SetYAMLVar>

  It a equivalent below. 

  <mt:SetVars>
  foo=1
  bar=2
  baz=3
  </mt:SetVars>

B<Example2: Create a hash template variable.>

  <mt:SetYAMLVar name="hash">
  foo: 1
  bar: 2
  baz: 3
  </mt:SetYAMLVar>

  or

  <mt:SetYAMLVar>
  hash:
    foo: 1
    bar: 2
    baz: 3
  </mt:SetYAMLVar>

  It a equivalent below. 

  <mt:SetHashVar name="hash">
    <$mt:SetVar name="foo" value="1"$>
    <$mt:SetVar name="bar" value="2"$>
    <$mt:SetVar name="baz" value="3"$>
  </mt:SetHashVar>

B<Example3: Create an array template variable.>

  <mt:SetYAMLVar name="array">
  - foo 
  - bar
  - baz
  </mt:SetYAMLVar>

  It a equivalent below. 

  <$mt:Var name="array[0]" value="foo"$>
  <$mt:Var name="array[1]" value="foo"$>
  <$mt:Var name="array[2]" value="foo"$>

=cut

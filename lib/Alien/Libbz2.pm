package Alien::Libbz2;

use strict;
use warnings;
use 5.008001;
use base 'Alien::Base';

# ABSTRACT: Build and make available bz2
# VERSION
# ALIEN SYNOPSIS

=head1 DESCRIPTION

This L<Alien> module provides the necessary compiler and linker flags needed
for using libbz2 in XS.

=head1 METHODS

=head2 bin_dir

 my @dirs = Alien::Libbz2->bin_dir;

Returns a list of directories that need to be added to C<PATH> in order to use
the command line tools.

=head2 cflags

 my $cflags = Alien::Libbz2->cflags;

Returns the C compiler flags.

=head2 libs

 my $libs = Alien::Libbz2->libs;

Returns the linker flags.

=head1 HELPERS

=head2 bzip2

 %{bzip2}

Returns the name of the bzip2 command.  Usually just C<bzip2>.

=cut

sub bin_dir
{
  my($class) = @_;
  my $override = $class->runtime_prop->{my_bin_dir};
  return ($override) if defined $override;
  $class->SUPER::bin_dir;
}

sub alien_helper
{
  return {
    bzip2 => sub { 'bzip2' },
  };
}

# TODO: this should eventually be correctly handled by
# Alien::Build
sub config {
  my($class, $key) = @_;
  return 'bz2' if $key eq 'name' || $key eq 'ffi_name';
  return $class->SUPER::config($key);
}

=head1 SEE ALSO

=over 4

=item L<Alien::bz2>

Another libbz2 L<Alien> module, but not implemented with L<Alien::Base>.

=item L<Compress::Bzip2>

=item L<Compress::Raw::Bzip2>

=item L<IO::Compress::Bzip2>

=back

=cut

1;

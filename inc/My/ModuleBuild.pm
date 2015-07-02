package My::ModuleBuild;

use strict;
use warnings;
use 5.008001;
use parent 'Alien::Base::ModuleBuild';
use Config;
use ExtUtils::CChecker;
use Capture::Tiny qw( capture );

sub alien_check_installed_version {
  my($self) = @_;
  
  my $cc = ExtUtils::CChecker->new(
    quiet  => 1,
    config => { libs => "$Config{libs} -lbz2" },
  );

  $cc->push_extra_linker_flags('-lbz2');

  my($version, undef, $ok) = capture {  
  
    my $code = <<EOF;
#include <stdio.h>
#include <bzlib.h>

int
main(int argc, char *argv[])
{
  printf("%s", BZ2_bzlibVersion());
  return 0;
}
EOF
  
    my $ok = $cc->try_compile_run(
      source => $code,
    );
  };
  
  return unless $ok;
  
  $version =~ s/,.*$//;
  
  $version;
}

sub alien_check_built_version {
  my($self) = @_;
  '1.0.6';
}

1;

#!/usr/bin/env perl
use strict;
use warnings;

use Cwd qw(abs_path);
use File::Which qw(which);

my $perl = which('perl');
my $path = abs_path('portal.pl');

my @cmd = ('start', $perl, $path, 'daemon');

system(@cmd) == 0 or die "system(@cmd) failed: $?";

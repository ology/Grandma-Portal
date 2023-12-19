#!/usr/bin/env perl

# nb: This is the wrapper that launches the portal

use strict;
use warnings;

use Cwd qw(abs_path);
use File::Which qw(which);

my $perl = which('perl');
my $path = abs_path('portal.pl');

my @cmd = ('start', '/min', $perl, $path, 'daemon');
system(@cmd) == 0 or die "system(@cmd) failed: $?";

@cmd = ('start', 'firefox', 'http://127.0.0.1:3000/');
system(@cmd) == 0 or die "system(@cmd) failed: $?";

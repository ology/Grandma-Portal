#!/usr/bin/env perl

# nb: I thought this was needed, but it turns out not to be

use strict;
use warnings;

use File::Which qw(which);

my $pp = which('pp');

my @cmd = ($pp, qw(-g -o run-portal.exe run-portal.pl));

system(@cmd) == 0 or die "system(@cmd) failed: $?";


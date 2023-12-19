#!/usr/bin/env perl

# nb: This is experimental so far...

use strict;
use warnings;

use File::Which qw(which);

my $pp = which('pp');

my @cmd = ($pp, qw(-g -o portal.exe portal.pl));

system(@cmd) == 0 or die "system(@cmd) failed: $?";


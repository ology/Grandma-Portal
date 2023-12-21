#!/usr/bin/env perl

# nb: This is the wrapper that launches the portal for Windows

use strict;
use warnings;

use Cwd qw(abs_path);
use File::Which qw(which);
use List::Util qw(any);
use Win32::Process::List ();

my $perl = which('perl');
my $path = abs_path('portal.pl');

my $proc = Win32::Process::List->new;
my %list = $proc->GetProcesses; # hashes with PID and process name

my @cmd;

# don't restart the portal
unless (any { $list{$_} =~ /^perl\.exe$/ } keys %list) {
  @cmd = ('start', '/min', $perl, $path, 'daemon');
  system(@cmd) == 0 or die "system(@cmd) failed: $?";
}

@cmd = ('start', 'firefox', 'http://127.0.0.1:3000/');
system(@cmd) == 0 or die "system(@cmd) failed: $?";

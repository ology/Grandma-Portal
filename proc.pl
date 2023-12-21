#!/usr/bin/env perl
use strict;
use warnings;

use List::Util qw(any);
use Win32::Process::List ();

my $proc = Win32::Process::List->new;

my %list = $proc->GetProcesses; # hashes with PID and process name

print "Perl!\n" if any { $list{$_} =~ /^perl\.exe$/ } keys %list;


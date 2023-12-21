#!/usr/bin/env perl
use strict;
use warnings;

use Win32::Process::List ();

my $proc = Win32::Process::List->new;

my %list = $proc->GetProcesses; # hashes with PID and process name

for my $key (keys %list) {
      # $list{$key} is now the process name and $key is the PID
      print sprintf "%30s has PID %15s\n", $list{$key}, $key;
}

my $pid = $proc->GetProcessPid('run-portal');
warn __PACKAGE__,' L',__LINE__,' ',,"PID: $pid\n";

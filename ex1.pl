#!/usr/bin/perl

use strict;
use warnings;

print "Exercise 1\n";

unless ( $ARGV[0] )
{
 Usage("Log file are not determined");
}


unless ( -f $ARGV[0] )
{
 Usage("Can't find log file: $ARGV[0]");
}

my $log = $ARGV[0];

open my $f, "< $log" or Usage("Can't open $log: $!");
my %ks = ();
my $line = 1;
while (my $log_str = <$f>)
{
 chomp $log_str;
 if (exists $ks{$log_str} )
 {
  push @{$ks{$log_str}}, $line;
 }
 else
 {
  $ks{$log_str} = [$line];
 } 
 $line++;
}
close $f;

foreach my $k ( keys %ks )
{
 if ( scalar @{$ks{$k}} > 1 )
 {
  show_duble($ks{$k}, $k);
 }
} 


use Data::Dumper;

sub show_duble
{
 my ($ar, $key) = @_;

 print "-"x20,"\n";
 print "String: $key\n";
 print "Duplicates at lines: ", (join ',', @$ar ), "\n";
}

sub Usage
{
 my $s = shift;
 print "Error: $s\n";
 print "USAGE:\n";
 print "$0 logfilename\n";
 exit;
}


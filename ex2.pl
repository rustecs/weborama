#!/usr/bin/perl

use strict;
use warnings;

print "Exercise 2\n";

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
 my $an_key = make_key($log_str);

 if (exists $ks{$an_key} )
 {
  push @{$ks{$an_key}}, [$log_str, $line];
 }
 else
 {
  $ks{$an_key} = [ [$log_str, $line] ];
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



sub make_key
{
 my $s = shift;
 return join '', sort map{lc($_)} split //, $s;
}

sub show_duble
{
 my ($ar, $key) = @_;

 print "-"x20,"\n";
 print "Anagram list: \n";
 for my $inst ( @$ar )
 {
  printf("Instance: %s at line %d\n", $$inst[0], $$inst[1]);
 }
}


sub Usage
{
 my $s = shift;
 print "Error: $s\n";
 print "USAGE:\n";
 print "$0 logfilename\n";
 exit;
}


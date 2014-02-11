#!env perl

print "{[\n";

while(<>) {
  my $current = $_;
  my $fh = IO::File->new(); 
  $fh->open($_);
  while(<$fh>) {
    print $_;
    if (!($current =~ /^1325/)) {
      print ",";
    }
    print "\n";
  }
  $fh->close();
}

print "]}";

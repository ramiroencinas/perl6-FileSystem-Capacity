use v6;

unit module Filesystem::Capacity::VolumesInfo;

sub volumes-info is export {

  given $*KERNEL {
    when $_ ~~ /linux/ { return linux; }
  }
}

sub linux {
  my @df-output = ((run 'df', '-k', :out).out.slurp-rest).lines;
  @df-output.shift;
  my %ret;

  for @df-output {
    my @line = $_.split(/\s+/);

    %ret{@line[5]} = {
      'size'  => @line[1],
      'used'  => @line[2],
      'used%' => @line[4],
      'free'  => @line[3]
    };
  }

  return %ret;
}

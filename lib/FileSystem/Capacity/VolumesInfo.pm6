use v6;

unit module Filesystem::Capacity::VolumesInfo;

sub volumes-info is export {
  given $*KERNEL {
    when /linux/  { linux; }
    when /win32/  { win32; }
    when /darwin/ { osx; }
  }
}

sub linux {
  my @df-output = ((run 'df', '-k', :out).out.slurp-rest).lines;
  @df-output.shift;
  my %ret;

  for @df-output {
    my @line = $_.words;

    %ret{@line[5]} = {
      'size'  => @line[1],
      'used'  => @line[2],
      'used%' => @line[4],
      'free'  => @line[3]
    };
  }

  return %ret;
}

sub win32 {
  my @wmic-output = ((shell "wmic /node:'%COMPUTERNAME%' LogicalDisk Where DriveType='3' Get DeviceID,Size,FreeSpace", :out).out.slurp-rest).lines;
  @wmic-output.shift;
  my %ret;

  for @wmic-output {
    if $_ {
      my @line = $_.words;

      my $size = @line[2];
      my $free = @line[1];
      my $used = $size - $free;
      my $used-percent = (($used * 100) / $size).Int ~ "%";

      %ret{@line[0]} = {
        'size'  => $size,
        'used'  => $used,
        'used%' => $used-percent,
        'free'  => $free
      };
    }
  }

  return %ret;
}

sub osx {
  my @df-output = ((run 'df', '-k', :out).out.slurp-rest).lines;
  @df-output.shift;
  my %ret;

  for @df-output {
    my @line = $_.words;

    %ret{@line[8]} = {
      'size'  => @line[1],
      'used'  => @line[2],
      'used%' => @line[4],
      'free'  => @line[3]
    };
  }

  return %ret;
}

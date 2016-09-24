use v6;

unit module Filesystem::Capacity::VolumesInfo;

sub volumes-info ( $human? ) is export {
  given $*KERNEL {
    when /linux/  { with $human { linux($human) } else { linux }; }
    when /win32/  { with $human { win32($human) } else { win32 }; }
    when /darwin/ { with $human { osx($human) } else { osx }; }
  }
}

sub linux ( $human? ) {
  my @df-output = ((run 'df', '-k', :out).out.slurp-rest).lines;
  @df-output.shift;
  my %ret;

  for @df-output {
    my @line = $_.words;

    with $human {
      %ret{@line[5]} = {
        'size'  => byte-to-human(@line[1].Int * 1024),
        'used'  => byte-to-human(@line[2].Int * 1024),
        'used%' => @line[4],
        'free'  => byte-to-human(@line[3].Int * 1024)
      };
    } else {
      %ret{@line[5]} = {
        'size'  => @line[1].Int * 1024,
        'used'  => @line[2].Int * 1024,
        'used%' => @line[4],
        'free'  => @line[3].Int * 1024
      };
    }
  }

  return %ret;
}

sub win32 ( $human? ) {
  my @wmic-output = ((shell "wmic /node:'%COMPUTERNAME%' LogicalDisk Where DriveType='3' Get DeviceID,Size,FreeSpace", :out).out.slurp-rest).lines;
  @wmic-output.shift;
  my %ret;

  for @wmic-output {
    if $_ {
      my @line = $_.words;

      my $size = @line[2].Int;
      my $free = @line[1].Int;
      my $used = ($size - $free);
      my $used-percent = (($used * 100) / $size).Int ~ "%";

      with $human {
        %ret{@line[0]} = {
          'size'  => byte-to-human($size),
          'used'  => byte-to-human($used),
          'used%' => $used-percent,
          'free'  => byte-to-human($free)
        };
      } else {
        %ret{@line[0]} = {
          'size'  => $size,
          'used'  => $used,
          'used%' => $used-percent,
          'free'  => $free
        };
      }
    }
  }

  return %ret;
}

sub osx ( $human? ) {
  my @df-output = ((run 'df', '-k', :out).out.slurp-rest).lines;
  @df-output.shift;
  my %ret;

  for @df-output {
    my @line = $_.words;

    with $human {
      %ret{@line[8]} = {
        'size'  => byte-to-human(@line[1].Int * 1024),
        'used'  => byte-to-human(@line[2].Int * 1024),
        'used%' => @line[4],
        'free'  => byte-to-human(@line[3].Int * 1024)
      };
    } else {
      %ret{@line[8]} = {
        'size'  => @line[1].Int * 1024,
        'used'  => @line[2].Int * 1024,
        'used%' => @line[4],
        'free'  => @line[3].Int * 1024
      };
    }
  }

  return %ret;
}

sub byte-to-human( Int:D $bytes ) is export {
  if $bytes.chars > 27 { return "Fail! Must be < 27 positions"; }

  my $i = 0;
  my $b = $bytes;

	my @scale = <Bytes KB MB GB TB PB EB ZB YB>;

	while $b > 1024 {
		$b = ($b / 1024).Int;
		$i++;
	}

	return $b.round(0.10) ~ " " ~ @scale[$i];

}

use v6;

unit module Filesystem::Capacity::DirSize;

sub dirsize ( Str:D $dirpath, :$human = False ) is export {
  
  return "No valid path directory" unless $dirpath.IO.e;

  my $ret;
  
  given $*KERNEL {
    
    when /linux/  { 
    	$ret = linux($dirpath); 
    	if $human { $ret = byte-to-human-du($ret); }
  	}     
  }  

  return $ret;
}

sub linux ( Str:D $dirpath ) {

  my @du-output = (run 'du', '-sb', $dirpath, :out).out.lines;
  
  my @words = @du-output[0].words;

  return @words[0].Int;
  
}


sub byte-to-human-du( Int:D $bytes ) is export {
  if $bytes.chars > 27 { return "Fail! Must be < 27 positions"; }

  my $i = 0;
  my $b = $bytes;

	my @scale = <Bytes KB MB GB TB PB EB ZB YB>;

	while $b > 1000 {
		$b = ($b / 1000).Int;
		$i++;
	}

	return $b.round(0.10) ~ " " ~ @scale[$i];
}
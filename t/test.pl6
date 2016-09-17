use v6;
use Test;

use lib '../lib';
use FileSystem::Capacity::VolumesInfo;

my %m = volumes-info();

for %m.sort(*.key)>>.kv -> ($location, $data) {
  say "Location: " ~ $location;
  say "Size: " ~ $data<size> ~ " bytes";
  say "Used: " ~ $data<used> ~ " bytes";
  say "Used%: " ~ $data<used%>;
  say "Free: " ~ $data<free> ~ " bytes";
  say "---";
}

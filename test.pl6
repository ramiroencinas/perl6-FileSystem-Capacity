use v6;
use FileSystem::Capacity::VolumesInfo;

my %vols = volumes-info();

for %vols.sort(*.key)>>.kv -> ($location, $data) {
  say "Location: $location";
  say "Size: $data<size> bytes";
  say "Used: $data<used> bytes";
  say "Used%: $data<used%>";
  say "Free: $data<free> bytes";
  say "---";
}

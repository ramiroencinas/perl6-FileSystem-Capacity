use v6;
use FileSystem::Capacity::VolumesInfo;

say "Byte version:\n";

my %vols = volumes-info();

for %vols.sort(*.key)>>.kv -> ($location, $data) {
  say "Location: $location";
  say "Size: $data<size> bytes";
  say "Used: $data<used> bytes";
  say "Used%: $data<used%>";
  say "Free: $data<free> bytes";
  say "---";
}

say "----";

say "Human version:\n";

my %vols-human = volumes-info(:human);

for %vols-human.sort(*.key)>>.kv -> ($location, $data) {
  say "Location: $location";
  say "Size: $data<size>";
  say "Used: $data<used>";
  say "Used%: $data<used%>";
  say "Free: $data<free>";
  say "---";
}

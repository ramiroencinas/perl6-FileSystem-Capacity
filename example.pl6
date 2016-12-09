use v6;
use FileSystem::Capacity::VolumesInfo;
use FileSystem::Capacity::DirSize;

say "Volumes Capacity Info:";
say "----------------------\n";

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

say "\n\nDirectory Size of /bin:";
say "----------------------\n";

my $dir = "/bin";

say " Byte version: " ~ dirsize($dir) ~ " bytes";
say "Human version: " ~ dirsize($dir, :human) ~ "\n";


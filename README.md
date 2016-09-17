FileSystem::Capacity
====================

Provides filesystem capacity info from the operating system utils and tools.

Currently implements Linux filesystem info provided by df command.

## Example Usage ##
    use v6;
    use FileSystem::Capacity::VolumesInfo;

    my %m = volumes-info();

    for %m.sort(*.key)>>.kv -> ($volume, $data) {
      say "Volume: " ~ $volume;
      say "Size: " ~ $data<size>;
      say "Used: " ~ $data<used>;
      say "Used%: " ~ $data<used%>;
      say "Free: " ~ $data<free>;
      say "---";
    }

FileSystem::Capacity
====================

Provides filesystem capacity info from the operating system utils and tools.

Currently implements:
* GNU/Linux filesystem info provided by df command from coreutils.
* Win32 filesystem info provided by wmic command.

## Example Usage ##
    use v6;

    use lib 'lib';
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

## TODO ##

* Provide other size scales like GB, MB, etc.

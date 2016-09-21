FileSystem::Capacity::VolumesInfo
=================================

Provides filesystem capacity info from the operating system utils and tools.

Currently implements:
* GNU/Linux filesystem info provided by df command from coreutils.
* Win32 filesystem info provided by wmic command.
* OS X filesystem info provided by df command.

## Installing the module ##

    panda update
    panda --notests install FileSystem::Capacity::VolumesInfo

    (I will resolve the travis test stuff to avoid --notests)

## Example Usage ##
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

## TODO ##

* Provide other size scales like GB, MB, etc.

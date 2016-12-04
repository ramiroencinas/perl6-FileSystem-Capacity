use v6;
use lib 'lib';
use Test;

plan 2;

use FileSystem::Capacity::VolumesInfo;

ok 1, "use FileSystem::Capacity::VolumesInfo worked!";

use-ok 'FileSystem::Capacity::VolumesInfo';
use v6;
use lib 'lib';
use Test;
use FileSystem::Capacity::VolumesInfo;

plan 2;

subtest {

	# byte version	
	my %vols = volumes-info();

	for %vols.sort(*.key)>>.kv -> ($location, $data) {
	  ok $location, "Exists location";
	  ok $data<size>, "Exists size";	 
	}
}

subtest {

	# human version	
	my %vols-human = volumes-info(:human);

	for %vols-human.sort(*.key)>>.kv -> ($location, $data) {
	  ok $location, "Exists location";
	  ok $data<size>, "Exists size";
	}
}
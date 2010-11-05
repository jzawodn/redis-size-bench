#!/usr/bin/perl -w
$|=1;

use strict;
use lib '/home/jzawodn/git/craigslist/lib/perl';
use Redis;

my $num_hashes = 10_000;
my $redis = Redis->new();

for my $num_hash_items (1, 2, 10, 50, 100, 200, 500, 1000) {
	$redis->flushall;

	# populate keyspace a bit
	$redis->set("blah:$_", $_) for 1..100_000;

	# populate the hashes
	for my $knum (1..$num_hashes) {
		my $key = "foo:$knum";
		for my $enum (1..$num_hash_items) {
			$redis->hset($key, $enum, $enum);
		}
	}

	my $info = $redis->info;
	printf "%d hashes of %d pairs, %d total in %d bytes ram, %d/pair\n",
		$num_hashes,
		$num_hash_items,
		($num_hashes * $num_hash_items),
		$info->{'used_memory'},
		($info->{'used_memory'} / ($num_hashes * $num_hash_items));
}

exit;

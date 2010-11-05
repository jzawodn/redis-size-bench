#!/usr/bin/perl -w
$|=1;

use strict;
use lib '/home/jzawodn/git/craigslist/lib/perl';
use Redis;

my $num_zsets = 10_000;
my $redis = Redis->new();

for my $num_zset_items (1, 2, 10, 50, 100, 200, 500, 1000) {
	$redis->flushall;

	# populate keyspace a bit
	$redis->set("blah:$_", $_) for 1..100_000;

	# populate the zsets
	for my $knum (1..$num_zsets) {
		my $key = "foo:$knum";
		for my $enum (1..$num_zset_items) {
			$redis->zadd($key, $enum, $enum);
		}
	}

	my $info = $redis->info;
	printf "%d zsets of %d members, %d total in %d bytes ram, %d/member\n",
		$num_zsets,
		$num_zset_items,
		($num_zsets * $num_zset_items),
		$info->{'used_memory'},
		($info->{'used_memory'} / ($num_zsets * $num_zset_items));
}

exit;

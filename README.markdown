Redis Size Benchmarking Tools
=============================

So often when using Redis, I find myself wondering what the best
representation for data is.  And I wish I had an easy way of checking to
see how much space different representations might take.  So I find
myself writing little tools to help with those decisions.

Those tools are here.

redis_zset_ram.pl
-----------------

This tool is used to demonstrate the memory overhead of sort sets
(ZSETs) in Redis.  It connects to the local Redis instance, calls
FLUSHALL, then creates 100,000 simple key/value pairs (to simulate
having "other stuff in the keyspace) and then creates 10,000 ZSETs with
a number of members (integers).  It then produces a line of stats for
that run and moves on to the next one.

It currently does runs for the following set sizes:

   * 1
   * 2
   * 10
   * 50
   * 100
   * 500
   * 1,000
   * 5,000

Here's a sample run on my notebook (64bit Redis 2.1.5):

<pre>
$ ./redis_zset_ram.pl
10000 zsets of 1 members, 10000 total in 69979720 bytes ram, 6997/member
10000 zsets of 2 members, 20000 total in 70834600 bytes ram, 3541/member
10000 zsets of 10 members, 100000 total in 79337864 bytes ram, 793/member
10000 zsets of 50 members, 500000 total in 116593304 bytes ram, 233/member
10000 zsets of 100 members, 1000000 total in 164377880 bytes ram, 164/member
10000 zsets of 500 members, 5000000 total in 536431064 bytes ram, 107/member
10000 zsets of 1000 members, 10000000 total in 1004059720 bytes ram, 100/member
10000 zsets of 2000 members, 20000000 total in 1939253688 bytes ram, 96/member
</pre>

An earlier attempt at doing this for a Craigslist-specific
implementation resulted in some data that I shared in the #redis
freenode IRC channel: [Google Docs spreadsheet] (https://spreadsheets.google.com/ccc?key=0ArKuF62RTXBLdGkwbkh2WUY0RE9GcTl5QnB2Nk5sZkE&hl=en)

redis_hash_ram.pl
-----------------

This tool does the same thing as redis_zset_ram but using hashes.

Here's an example run from it:

<pre>
10000 hashes of 1 pairs, 10000 total in 11438000 bytes ram, 1143/pair
10000 hashes of 2 pairs, 20000 total in 11526128 bytes ram, 576/pair
10000 hashes of 10 pairs, 100000 total in 11926128 bytes ram, 119/pair
10000 hashes of 50 pairs, 500000 total in 14726128 bytes ram, 29/pair
10000 hashes of 100 pairs, 1000000 total in 59696072 bytes ram, 59/pair
10000 hashes of 200 pairs, 2000000 total in 106839016 bytes ram, 53/pair
10000 hashes of 500 pairs, 5000000 total in 213986608 bytes ram, 42/pair
10000 hashes of 1000 pairs, 10000000 total in 414240048 bytes ram, 41/pair
</pre>

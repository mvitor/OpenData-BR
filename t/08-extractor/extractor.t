use Test::More tests => 7;

use strict;

package OnlyTest;

    use Moose;
    with 'OpenData::Extractor';

    sub extract { 1 }

    1;

package MyExtractor;

    use Moose;
    with 'OpenData::Extractor';

    our $storage = [ qw/ddd eee fff/ ];

    sub extract {
        shift;
        return shift @{$MyExtractor::storage};
    }
    1;

package main;

my $obj = OnlyTest->new;
ok($obj);
ok($obj->extract == 1);

my $source = MyExtractor->new;
ok($source);
ok($source->extract eq 'ddd');
ok($source->extract eq 'eee');
ok($source->extract eq 'fff');

my $undef = $source->extract;
ok(!$undef);


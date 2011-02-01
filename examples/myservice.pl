#!perl

use strict;
use warnings;
use lib '../lib';
use Data::Dumper;
use MyService;
use BookingRequest;
use Domuyo::RPC::JSON::Descriptor;
use JSON;

#print Dumper(MyService->META);
#print Dumper(BookingRequest->META);
my $controller = MyService->new;

my $json = JSON->new;
$json->pretty(1);

my $ws = Domuyo::RPC::JSON::Descriptor->new($controller->META, '/service');
print $ws->describe."\n";
#print $json->encode($json->decode($ws->describe))."\n";

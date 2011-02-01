package MyService;

use strict;
use warnings;
use base qw(Domuyo::Controller);
use BookingRequest;

sub add : PUBLIC(Int a, Int b) RETURNS(Int) {
    my ( $self, %args ) = @_;
    return $args{a} + $args{b};
}

sub book : PUBLIC(BookingRequest a) RETURNS(Bool) {
    
}

sub private {

}

1;

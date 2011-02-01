package BookingRequest;

use strict;
use warnings;
use base qw(Domuyo::Object);


sub date : ACCESSOR(Str) {
    my $self = shift;
    if (@_) {
        $self->{date} = shift;
    }
    return $self->{date};
}

sub name : ACCESSOR(Str) {
    my $self = shift;
    if (@_) {
        $self->{date} = shift;
    }
    return $self->{date};
}

1;

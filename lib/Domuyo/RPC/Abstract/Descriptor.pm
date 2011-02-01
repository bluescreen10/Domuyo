
package Domuyo::RPC::Abstract::Descriptor;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $meta = shift;

    my $self = bless { meta => $meta }, $class;
    $self->_init(@_);
    return $self;
}

sub describe {
    my $self = shift;

    unless ( $self->{_cache} ) {
        $self->{_cache} = $self->_describe;
    }

    return $self->{_cache};

}

sub _init {}

1;

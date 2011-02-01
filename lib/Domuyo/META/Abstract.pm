
=head1 NAME

Domuyo::Meta::Abstract - TDB

=head1 SYNOPSYS

=cut

package Domuyo::META::Abstract;

use strict;
use warnings;

sub new {
    my $class = shift;

    my $self = bless { finish => 0 }, $class;
    $self->_init(@_);
    return $self;
}

sub finish {

}

sub is_finished {
    my $self = shift;
    return $self->{finish};
}

sub _init { }

sub _is_native_type {
    my ( $self, $type ) = @_;

    if (   $type eq 'Int'
        or $type eq 'Str'
        or $type eq 'Array'
        or $type eq 'Hash'
        or $type eq 'Float'
        or $type eq 'Bool' )
    {
        return 1;
    }

    return 0;
}

sub _is_valid_type {
    my ( $self, $type ) = @_;

    return ($self->_is_native_type($type) or $type->can('META'));
}

1;

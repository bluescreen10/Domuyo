
=head1 NAME

Domuyo::META::Object - TDB

=head1 SYNOPSYS

=cut

package Domuyo::META::Object;

use strict;
use warnings;
use base qw(Domuyo::META::Abstract);

=head1 METHODS

=head2 attributes

=cut

sub attributes {
    my $self = shift;
    return $self->{attributes};
}

=head2 finish

=cut

sub finish {
    my ( $self, $class ) = @_;

    no strict 'refs';

    foreach ( keys %{ $class . '::' } ) {
        my $code = $class->can($_);
        if ( $code and exists $self->{attributes}->{$code} ) {
            $self->{attributes}->{$_} = $self->{attributes}->{$code};
            $self->{attributes}->{$_}->{name} = $_;
            delete $self->{attributes}->{$code};
        }
    }

    use strict 'refs';

    $self->{finish} = 1;
}


=head2 parse_attributes

=cut

sub parse_attributes {
    my ( $self, $code, @attrs ) = @_;

    my @invalid_attrs;
    foreach my $attr (@attrs) {
        if ( $attr =~ /^(?:accessor|setter|attribute)\((.*)\)/i ) {
            $self->_parse_accessor( $code, $1 );
        }
        elsif ( $attr =~ /^getter\(/ ) {

            # Don't care
        }
        else {
            push( @invalid_attrs, $attr );
        }
    }
    return @invalid_attrs;
}

=head1 PRIVATE METHODS

=head2 _init

=cut

sub _init {
    my $self = shift;

    $self->{attributes} = {};

}

=head2 _parse_accessor

=cut

sub _parse_accessor {
    my ( $self, $code, $expr ) = @_;

    if ( $self->_is_valid_type($expr) ) {
        $self->{attributes}->{$code}->{type}   = $expr;
        $self->{attributes}->{$code}->{native} = $self->_is_native_type($expr);
        $self->{attributes}->{$code}->{coderef} = $code;
    }
    else {
        die "Invalid data type $expr";
    }
}


1;


=head1 NAME

Domuyo::META::Controller - TDB

=head1 SYNOPSYS

=cut

package Domuyo::META::Controller;

use strict;
use warnings;
use base qw(Domuyo::META::Abstract);

=head1 METHODS

=head2 finish

=cut

sub finish {
    my ( $self, $class ) = @_;

    no strict 'refs';

    foreach ( keys %{ $class . '::' } ) {
        my $code = $class->can($_);
        if ( $code and exists $self->{methods}->{$code} ) {
            $self->{methods}->{$_} = $self->{methods}->{$code};
            $self->{methods}->{$_}->{name} = $_;
            delete $self->{methods}->{$code};
        }
    }

    use strict 'refs';

    $self->{finish} = 1;
}

=head2 methods

=cut

sub methods {
    my $self = shift;
    return $self->{methods};
}

=head2 parse_attributes

=cut

sub parse_attributes {
    my ( $self, $code, @attrs ) = @_;

    my @invalid_attrs;

    foreach my $attr (@attrs) {
        if ( $attr =~ /^(?:public|method)(?:\((.*)\))?/i ) {
            $self->_parse_parameters( $code, $1 );
        }
        elsif ( $attr =~ /^(?:returns|return)(?:\((.*)\))?/i ) {
            $self->_parse_return( $code, $1 );
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

=head2 _parse_parameters

=cut

sub _parse_parameters {
    my ( $self, $code, $expr ) = @_;

    my $params = [];

    foreach my $param ( split( ',', $expr ) ) {
        if ( $param =~ /^\s*([\w\d]+)\s+([\w\d]+)\s*/ ) {
            if ( $self->_is_valid_type($1) ) {
                push( @$params, { name => $2, type => $1 } );
            } else {
                die "Invalid data type $1\n";
            }
        }
        else {
            die "Invalid parameter $param";
        }
    }
    $self->{methods}->{$code}->{params} = $params;
}

=head2 _parse_return

=cut

sub _parse_return {
    my ( $self, $code, $expr ) = @_;
    if ( $self->_is_valid_type($expr) ) {
        $self->{methods}->{$code}->{returns} = $expr;
    }
    else {
        die "Invalid type $expr";
    }
}


1;

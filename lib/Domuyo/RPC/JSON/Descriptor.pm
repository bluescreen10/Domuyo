
=head1 NAME

Domuyo::JSON::Descriptor -TBD

=head1 SYNOPSIS

=cut

package Domuyo::RPC::JSON::Descriptor;

use strict;
use warnings;
use base qw(Domuyo::RPC::Abstract::Descriptor);
use Data::Dumper;

my %native_data_types = (
    Str   => '"string"',
    Int   => '"integer"',
    Float => '"float"',
    Void  => '"null"',
    Bool  => '"boolean"'
);

=head1 PRIVATE METHODS

=head2 _describe

=cut

sub _describe {
    my $self = shift;

    my $desc = $self->_describe_header . $self->_describe_methods . $self->_describe_footer;

    #clean up
    $desc =~s/,}/}/g;
    return $desc;
}

=head2 _describe_complex_type

=cut

sub _describe_complex_type {
    my ( $self, $type ) = @_;

    my $attributes = $type->META->attributes;

    my $desc = '{';
    foreach my $attr ( keys %$attributes ) {
        $desc .= '"'.$attributes->{$attr}->{name}.'":'.
                '{"type":'. $self->_map_data_type( $attributes->{$attr}->{type}) .'},';
    }
    $desc .= '}';

    return $desc;

}

=head2 _describe_footer

=cut

sub _describe_footer {
    return '}';
}

=head2 _describe_header

=cut

sub _describe_header {
    my $self = shift;
    return '{"transport":"POST","envelope":"json-rpc-2.0","serviceUrl":"'. $self->{uri}.'",';
}

=head2 _describe_method

=cut

sub _describe_method {
    my ( $self, $method ) = @_;

    my $desc = '"' . $method->{name} . '":{';

    if ( $method->{params} and scalar( @{ $method->{params} } ) ) {
        $desc .= '"parameters": {';
        $desc .= join( ',', map { $self->_describe_param($_) } @{ $method->{params} } );
        $desc .= '},';
    }

    if ( $method->{returns} ) {
        $desc .= '"returns":' . $self->_map_data_type( $method->{returns} );
    }

    $desc .= '}';

    return $desc;

}

=head2 _describe_methods

=cut

sub _describe_methods {
    my $self = shift;

    my $desc = '';

    my $methods = $self->{meta}->methods;
    if ( $methods and scalar( keys %{$methods} ) ) {
        $desc .= '"methods": {';
        $desc .= join( ',', map { $self->_describe_method( $methods->{$_} ) } keys %{$methods} );
        $desc .= '}';
    }
}

=head2 _describe_param

=cut

sub _describe_param {
    my ( $self, $param ) = @_;
    return '"' . $param->{name} . '":'.
           '{"type":' . $self->_map_data_type( $param->{type} ) . '}';
}

=head2 _init

=cut

sub _init {
    my ( $self, $uri ) = @_;
    $self->{uri} = $uri;
}


=head2 _map_data_type

=cut

sub _map_data_type {
    my ( $self, $type ) = @_;

    if ( $native_data_types{$type} ) {
        return $native_data_types{$type};
    }

    return $self->_describe_complex_type($type);
}


1;


package Domuyo::RPC::JSON::FrontController;

use strict;
use warnings;
use base qw(Domuyo::FrontController);
use JSON qw(decode encode);

sub _dispatch {
    my ( $self, $request, $response ) = @_;

    eval {
        my ( $method, $params ) = $self->_unwrap($request);
        my $controller = $self->_controller_for($method);
        $self->_validate_params( $controller, $method, $params );
        my $value = $controller->$method(%$params);
        return $self->_wrap($request, $response, $value);
    };

    if ($@) {
        $self->_error($request, $response, $@);
    }

}

sub _unwrap {
    my ( $self, $wrapped_request ) = @_;

    my $request = decode($wrapped_request->content);

    unless ( $request->{jsonrpc} eq '2.0' ) {
        die "Invlalid version";
    }

    return ( $request->{method}, $request->{params} );

}

sub _controller_for {
    my ( $self, $method ) = @_;
}

1;

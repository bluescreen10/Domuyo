
package Domuyo::FrontController;

sub new {
    my $class = shift;

    my $self = bless {
        pre_filters  => [],
        post_filters => []
    }, $class;
    $self->_init(@_);
    return $self;
}

sub dispatch {
    my ( $self, $request, $response ) = @_;

    my $status = 1;

    foreach my $filter ( @{$self->{pre_fitlers}} ) {
        $status = $filter->process($request, $response);
        return $status unless $status;
    }

    $self->_dispatch($request,$response);

    foreach my $filter ( @{$self->{post_filters}} ) {
        $status = $filter->process($request, $response);
        return $status unless $status;
    }

    return 1;
}

sub _dispatch {}

1;

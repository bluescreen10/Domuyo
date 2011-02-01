#!perl

use strict;
use warnings;
use MyController;

sub mappings {
    {
        '/TEST'     => MyController,
        '/service/' => MyController
    };
}

package MyService;

use strict;
use warnings;

use base qw(WebService);

$dispatch->($req, $resp);


sub dispatch {

    my $status;

    foreach my $filter ( $self->pre_filters ) {
        $status = $filter->process($req,$resp);
        last unless $status;
    }

    $self->_dispatch($req, $resp);

    foreach my $filter ( $self->post_filters ) {
        last unless $filter->process($req,$resp);
    }

}

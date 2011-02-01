
=head1 NAME

Domuyo::RPC::JSON - TBD

=head1 SYNOPSIS

=cut

package Domuyo::RPC::JSON;

use strict;
use warnings;
use Domuyo::RPC::JSON::Descriptor;

sub describe {
    return $self->{descriptor}->describe;
}

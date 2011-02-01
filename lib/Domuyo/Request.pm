=head1 NAME

=head1 SYNOPSIS

=cut

package Domuyo::Request;

sub new {
    my $class = shift;
    my $self  = bless {
        headers    => {},
        parameters => {},
        content    => undef,
        source_ip  => undef,
        cookies    => undef,
        attributes => {},
    }, $class;
    return $self;
}

sub attribute {
    my $self      = shift;
    my $attribute = shift;

    if (@_) {
        $self->{attributes}->{$attribute} = shift;
    }

    return $self->{attributes}->{$attribute};

}

sub content {
    my $self = shift;
    if (@_) {
        $self->{content} = shift;
    }
    return $self->{content};
}

sub headers {
    my $self = shift;
    if (@_) {
        $self->{headers} = shift;
    }
    return $self->{headers};
}

sub parameters {
    my $self = shift;
    if (@_) {
        $self->{parameters} = shift;
    }
    return $self->{parameters};
}

sub source_ip {
    my $self = shift;
    if (@_) {
        $self->{source_ip} = shift;
    }
    return $self->{source_ip};
}

1;

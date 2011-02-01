package WebService;

use strict;
use warnings;

sub new {
    my ( $class, $controller ) = @_;

    my $self = bless { controller => $controller }, $class;

    return $self;
}

sub describe {
    my $self = shift;

    return
        $self->_describe_header
      . $self->_describe_types
      . $self->_describe_interfaces
      . $self->_describe_bindings
      . $self->_describe_services
      . $self->_describe_footer;

}

sub _describe_bindings {
    return '';
}

sub _describe_footer {
    return '    </wsdl:description>';
}

sub _describe_header {
    return <<HEADER;
<?xml version="1.0"?>
    <wsdl:description xmlns:wsdl="http://www.w3.org/ns/wsdl"
                      xmlns:wsoap= "http://www.w3.org/ns/wsdl/soap"
                      xmlns:hy="http://www.herongyang.com/Service/"
                      targetNamespace="http://www.herongyang.com/Service/">
HEADER

}

sub _describe_interfaces {
    my $self = shift;
    my $meta = $self->{controller}->META;

    my $description = $self->_describe_interfaces_header;

    foreach my $key ( keys %{$meta->{methods}} ) {
        my $method = $meta->{methods}->{$key};
         $description .= '<operation name="'. $method->{name}.'">';
        $description .= '<input message="" />';
        $description .= '<input output="" />';
        $description .= '</operation>';
    }

    $description .= $self->_describe_interfaces_footer;

}

sub _describe_interfaces_header {
    return '<interface name="Hello">';
}

sub _describe_interfaces_footer {
    return '</interface>';
}


sub _describe_services {
    return '';
}

sub _describe_types{
    return '';
}


1;

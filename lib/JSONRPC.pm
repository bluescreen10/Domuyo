package JSONRPC;

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
      . $self->_describe_services
      . $self->_describe_footer;

}

sub _describe_footer {
    return "}\n";
}

sub _describe_header {
    return <<HEADER;
{
    "transport": "POST",
    "envelope" : "JSON-RPC-2.0",
    "target"   : "/service/",
HEADER
}

sub _describe_services {
    my $self = shift;

    my $services = "    services: {\n";

    my $meta = $self->{controller}->META;

    foreach my $key ( keys %{$meta->{methods}} ) {
        my $method = $meta->{methods}->{$key};
        $services .= '        "'.$method->{name}."\": {\n";
        $services .= '            "parameters": ['."\n";
        foreach my $param ( @{$method->{params}}) {
            $services .= '            {"type": "'.$param->{type}.'", "name":"'.$param->{name}.'"},'."\n";
        }
        $services .= "            ]\n";
        $services .= "        }\n";

    }
 
    return $services ."    }\n";
}


1;

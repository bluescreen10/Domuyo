
=head1 NAME

Domuyo::Abstract - TDB

=head1 SYNOPSYS

=cut

package Domuyo::Abstract;

use strict;
use warnings;
use Domuyo::META::Controller;
use Domuyo::META::Object;

my $META;

sub new {
    my $class = shift;

    my $self = bless {}, $class;
    $self->_init(@_);
    return $self;

}

sub MODIFY_CODE_ATTRIBUTES {
    my ( $class, $code, @attrs) = @_;

    unless ( $META->{$class} ) {
        $META->{$class} = ("Domuyo::META::".$class->META_TYPE)->new;
    }

    return $META->{$class}->parse_attributes($code, @attrs);
}

sub META {
    my $self = shift;

    my $class = ref($self) || $self;

    unless ( $META->{$class}->is_finished ) {
        $META->{$class}->finish($class);
    }

    return $META->{$class};

}

sub META_TYPE { }

sub _init { }

1;

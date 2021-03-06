package Pabbix::Template::Create;

use strict;
use warnings;
use Moo;
use Pabbix::Request;

extends 'Pabbix::Template::Base';

sub create
{
    my $self = shift;
    $self->method( 'template.create' );
    my $response = Pabbix::Request->new(
        url => $self->url,
        json => $self->_createJson,
    );
    return $response->get;
}

1;

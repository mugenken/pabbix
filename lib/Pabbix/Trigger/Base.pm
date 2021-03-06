package Pabbix::Trigger::Base;

use strict;
use warnings;
use Moo;

extends 'Pabbix::Base';

sub _add_missing_params
{
    my $self = shift;
    $self->_add_status;
    $self->_add_hostid;
    $self->_add_host;
    $self->_add_description;
    $self->_add_expression;
    $self->_add_nodeids;
    $self->_add_triggerids;
    $self->_add_trigger;
}

sub _add_status
{
    my $self = shift;
    if( defined( $self->statusValue ) )
    {
        my $json = $self->json;
        $json->{'params'}{'output'} = 'extend';
        $json->{'params'}{'expandData'} = 'host';
        $json->{'params'}{'filter'}{'value'} = $self->_translateStatus;
        $self->json( $json );
    }
}

sub _add_hostid
{
    my $self = shift;
    if( $self->hostid )
    {
        my $json = $self->json;
        $json->{'params'}{'hostid'} = $self->hostid;
        $self->json( $json );
    }
}

sub _add_host
{
    my $self = shift;
    if( $self->host )
    {
        my $json = $self->json;
        $json->{'params'}{'host'} = $self->host;
        $self->json( $json );
    }
}

sub _add_description
{
    my $self = shift;
    if( $self->description )
    {
        my $json = $self->json;
        $json->{'params'}{'description'} = $self->description;
        $self->json( $json );
    }
}

sub _add_expression
{
    my $self = shift;
    if( $self->expression )
    {
        my $json = $self->json;
        $json->{'params'}{'expression'} = $self->expression;
        $self->json( $json );
    }
}

sub _add_nodeids
{
    my $self = shift;
    if( $self->nodeids )
    {
        my $json = $self->json;
        $json->{'params'}{'nodeids'} = $self->nodeids;
        $self->json( $json );
    }
}

sub _add_triggerids
{
    my $self = shift;
    if( $self->triggerids )
    {
        my $json = $self->json;
        $json->{'params'} = $self->triggerids;
        $self->json( $json );
    }
}

sub _add_trigger
{
    my $self = shift;
    if( $self->trigger )
    {
        my $json = $self->json;
        $json->{'params'} = $self->trigger;
        $self->json( $json );
    }
}

sub _translateStatus
{
    my $self = shift;
    if(
        ! defined( $self->statusValue ) ||
        $self->statusValue eq 'PROBLEM' ||
        $self->statusValue == 1 
    )
    {
        return 1;
    }
    elsif( 
        $self->statusValue eq 'OK' ||
        $self->statusValue == 0
    )
    {
        return 0;
    }
    elsif( 
        $self->statusValue eq 'UNKNOWN' ||
        $self->statusValue == 2
    )
    {
        return 2;
    }
    else
    {
        die 'unknown status code';
    }
}

has url         => ( is => 'ro', required => 1 );
has authToken   => ( is => 'ro', required => 1 );
has statusValue => ( is => 'ro' );
has status      => ( is => 'ro' );
has host        => ( is => 'ro' );
has hostid      => ( is => 'ro' );
has description => ( is => 'ro' );
has expression  => ( is => 'ro' );
has nodeids     => ( is => 'ro' );
has triggerids  => ( is => 'ro' );
has trigger     => ( is => 'rw' );

1;

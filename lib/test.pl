#! /usr/bin/perl

use strict ;
use warnings ;
use Search::Elasticsearch ;
use kibini::elasticsearch ;
# use collections::biblio2 ;

my $es_node = GetEsNode() ;
my %params = ( nodes => $es_node ) ;
my $e = Search::Elasticsearch->new( %params ) ;

my $biblionumber = 298541 ;
    my %index = (
        index   => 'catalogue',
        type    => 'biblio',
        id      => $biblionumber
    ) ;
    my $exist = $e->exists(\%index) ;
    print "$exist\n" ;


sub _DelBiblioFromES {
    my ($e, $biblionumber) = @_ ;
    my %index = (
        index   => 'catalogue',
        type    => 'biblio',
        id      => $biblionumber
    ) ;
    my $exist = $e->exists(\%index) ;
    if ( $exist == 1 ) {
        $e->delete(\%index) ;
    }
}
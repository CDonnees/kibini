#! /usr/bin/perl

use strict ;
use warnings ;
use kibini::elasticsearch ;

my $id = GetEsMaxId( 'action_coop', 'actions', 'action_id' ) ;
print "$id\n" ;
#! /usr/bin/perl

use strict ;
use warnings ;
use FindBin qw( $Bin ) ;

use lib "$Bin/../lib" ;
use kibini::config ;
use kibini::time ;
use kibini::log ;

my $log_message ;
my $process = "statdb_load_koha_prod.pl" ;
# On log le début de l'opération
$log_message = "$process : beginning" ;
AddCrontabLog($log_message) ;

# On récupère les éléments de connexion MySQL
my $conf = GetConfig('database') ;
my $user = $conf->{user} ;
my $pwd = $conf->{pwd} ;

my $date = GetDateTime('today YYYYMMDD') ;
my $dir = "$Bin/../data" ;
my $file = "$dir/koha_prod_$date.sql" ;

# script initialement écrit en bash : on récupère tel quel...
system( "gunzip $file.gz" ) ;
system( "mysql -u $user -p$pwd koha_prod < $file" ) ;

# on corrige les ccodes des périodiques
system( "mysql -u $user -p$pwd koha_prod -e \"UPDATE koha_prod.items s JOIN statdb.lib_periodiques p ON s.biblionumber = p.biblionumber SET s.ccode = p.ccode\"" ) ;

system( "rm $file" ) ;

# On log la fin de l'opération
$log_message = "$process : ending\n" ;
AddCrontabLog($log_message) ;
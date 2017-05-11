package action_coop::form ;

use Exporter ;
@ISA = qw( Exporter ) ;
@EXPORT = qw( GetListActionsCooperation AddActionCooperation ) ;

use strict ;
use warnings ;
use FindBin qw( $Bin ) ;

use lib "$Bin/../lib" ;
use kibini::db ;

sub GetListActionsCooperation {
    my $dbh = GetDbh() ;
	my $req = <<SQL;
SELECT
*
FROM kib_sandbox.stat_action_coop
ORDER BY idstat_action_coop DESC
SQL
	return GetAllArrayRef($req) ;
}

sub AddActionCooperation {
	my ( $date, $lieu, $type, $nom, $type_structure, $nom_structure, $participants, $referent_action ) = @_ ;
	my $dbh = GetDbh() ;
	my $req = "INSERT INTO kib_sandbox.stat_action_coop (date, lieu, type, nom, type_structure, nom_structure, participants, referent_action ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)" ;
	my $sth = $dbh->prepare($req);
	$sth->execute( $date, $lieu, $type, $nom, $type_structure, $nom_structure, $participants, $referent_action ) ;
	$sth->finish();
	$dbh->disconnect();
}

1;

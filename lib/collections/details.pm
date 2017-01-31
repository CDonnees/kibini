package collections::details ;

use Exporter ;
@ISA = qw( Exporter ) ;
@EXPORT = qw( GetCcodeDetails ) ;

use strict ;
use warnings ;

use kibini::db ;
use collections::poldoc ;

sub GetCcodeDetails {
	my ($ccode, $site) = @_ ;
	my $dbh = GetDbh() ;
	my $statPoldocCollectionsMaxDate = _GetStatPoldocCollectionsMaxDate($dbh) ;
	my $req = "SELECT * FROM statdb.stat_poldoc_collections WHERE date = ? AND ccode = ? AND site = ? AND nb_exemplaires > 10" ;
	my $sth = $dbh->prepare($req) ;
	$sth->execute($statPoldocCollectionsMaxDate, $ccode, $site) ;
	my @rows ;
	while ( my $row = $sth->fetchrow_hashref ) {
		$row->{'support'} = GetLibAV( $row->{'support'}, 'ccode' ) ;
		$row->{'location'} = GetLibAV( $row->{'location'}, 'LOC' ) ;
		push @rows, $row ;
	}
	$sth->finish() ;
	return \@rows ;
}

sub _GetStatPoldocCollectionsMaxDate {
	my ($dbh) = @_ ;
	my $req = "SELECT MAX(date) FROM statdb.stat_poldoc_collections" ;
	my $sth = $dbh->prepare($req) ;
	$sth->execute() ;
	return $sth->fetchrow_array() ;
	$sth->finish() ;
}




1;

__END__
=pod

=encoding UTF-8

=head1 NOM

collections::details

=head1 DESCRIPTION

Ce module fournit des fonctions permettant d'obtenir le lib�ll� des cat�gories ou valeurs autoris�es pour les collections.

=cut
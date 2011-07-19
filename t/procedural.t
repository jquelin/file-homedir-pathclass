#!perl

use 5.010;
use strict;
use warnings;

use File::HomeDir ();
use File::HomeDir::PathClass '-all';
use Test::More;

my @subs = qw{ my_home my_desktop my_documents my_music };
plan tests => scalar(@subs) * 2;

foreach my $sub ( @subs ) {
    no strict 'refs';
    my $dir   = $sub->();
    my $fhdir = *{"File::HomeDir::$sub"}->();
    SKIP: {
        skip( "$sub not implemented on this platform", 2 )
            unless defined $dir;
        isa_ok( $dir, 'Path::Class::Dir', "$sub is wrapped" );
        is( $dir->stringify, $fhdir, "$sub is correctly wrapped" );
    }
}

use 5.010;
use strict;
use warnings;

package File::HomeDir::PathClass;
# ABSTRACT: File::HomeDir returning Path::Class objects

use File::HomeDir ();
use Path::Class;
use Sub::Exporter -setup => {
    exports => [ @File::HomeDir::EXPORT_OK ],
    #groups => {    },
};


foreach my $sub ( @File::HomeDir::EXPORT_OK ) {
    no strict 'refs';
    *{ $sub } = sub {
        shift if $_[0] eq __PACKAGE__;
        my $result = "File::HomeDir::$sub"->(@_);
        return dir( $result );
    };
}

1;
__END__

=for Pod::Coverage
    home
    ^my_
    ^users_

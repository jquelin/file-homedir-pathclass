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
        shift if defined($_[0]) && $_[0] eq __PACKAGE__;
        my $result = *{"File::HomeDir::$sub"}->(@_);
        return dir( $result );
    };
}

1;
__END__

=for Pod::Coverage
    home
    ^my_
    ^users_

=head1 SYNOPSIS

    use File::HomeDir::PathClass '-all';
    my $home = home();
    # $home is a Path::Class object now

    # - or -

    use File::HomeDir::PathClass;
    my $home = File::HomeDir::PathClass->home;
    # $home is a Path::Class object now


=head1 DESCRIPTION

This module is just a wrapper around L<File::HomeDir> methods,
transforming their return value to L<Path::Class> objects. This allows
for easier usage of the value.

Refer to L<File::HomeDir#METHODS> for a list of which functions are
supported.

C<File::HomeDir::PathClass> supports both original L<File::HomeDir> interfaces.


=head2 Procedural mode

All functions are exportable. Nothing is exported by default, though.
One has to list which function(s) she wants to import.

Some groups are defined for your convenience:

=over 4

=item * C<all> - all available functions.

=back

Note that this module is exporting subs via L<Sub::Exporter>, so groups
are available either as C<:group> or C<-group>. One can also play any
trick supported by L<Sub::Exporter>, check its documentation for further
information.


=head2 Class method mode

Otherwise, functions are available as class methods, called as:

    File::HomeDir::PathClass->method();

In this case, one doesn't need to import anything during module use-age.

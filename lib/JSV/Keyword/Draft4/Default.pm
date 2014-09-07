package JSV::Keyword::Draft4::Default;

use strict;
use warnings;
use parent qw(JSV::Keyword);

use B;
use JSON;

use JSV::Keyword qw(:constants);

sub instance_type() { INSTANCE_TYPE_ANY(); }
sub keyword() { "type" }
sub keyword_priority() { 10; }

sub validate {
    my ($class, $context, $schema, $instance) = @_;

    my $keyword_value = $class->keyword_value($schema);

    if (ref $keyword_value eq "ARRAY") {
        unless ( first { $class->validate_singular_type( $context, $_, $context->current_type, $instance ) } @$keyword_value ) {
            $context->log_error("instance type doesn't match schema type list");
        }
    }
    else {
        unless ($class->validate_singular_type( $context, $keyword_value, $context->current_type, $instance )) {
            $context->log_error("instance type doesn't match schema type");
        }
    }
}

sub validate_singular_type {
    my ($class, $context, $schema_type, $given_type, $instance) = @_;

    if ( $schema_type eq $given_type || ( $schema_type eq "number" && $given_type eq "integer") ) {
        return 1;
    }
    else {
        if ( $given_type eq "number_or_string" ) {
            return 1 if ( $schema_type eq "string" || $schema_type eq "number" );
        }
        elsif ( $given_type eq "integer_or_string" ) {
            return 1 if ( $schema_type eq "string" || $schema_type eq "number" || $schema_type eq "integer" );
        }
        return 0;
    }
}

1;

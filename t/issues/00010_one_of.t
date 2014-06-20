use strict;
use warnings;

use JSV::Validator;
use Test::More;

my $schema1 = +{
    oneOf => [
        +{
            type => 'object',
            properties => +{},
        },
    ],
};
my $schema2 = +{
    oneOf => [
        +{
            type => 'object',
            properties => +{},
        },
        +{
            type => 'object',
            properties => +{
                a => 3,
            },
        },
    ],
};

my $v = JSV::Validator->new( environment => "draft4" );

ok $v->validate($schema1, +{});
ok $v->validate($schema2, +{});

done_testing;

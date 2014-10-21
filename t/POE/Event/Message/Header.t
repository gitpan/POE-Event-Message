# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl POE-Event-Message.t'

#########################

use Test::More tests => 19;

BEGIN { use_ok('POE::Event::Message') };                     # 01

my $msg = new POE::Event::Message;
ok( defined $msg, "Instantiation okay" );                    # 02

#------------------------
# addRouteTo()

my(@origRoute) = ('post', 'service', 'event', "arg1","arg2");
my(@expected)  = ("","", @origRoute );
$msg->addRouteTo( @origRoute );

my $route = $msg->getRouteTo();
&testRouting( $route, @expected );  # sub defined just below # 03 - 06

#------------------------
# addRouteBack()

(@origRoute) = ('call', 'service', 'event', "arg1","arg2");
(@expected)  = ("","", @origRoute );
$msg->addRouteBack( @origRoute );

$route = $msg->getRouteBack();
&testRouting( $route, @expected );  # sub defined just below # 07 - 10

#------------------------
# addRemoteRouteTo()

(@origRoute) = ("host","port",'post', 'service', 'event', "arg1","arg2");
(@expected)  = (@origRoute );
$msg->addRemoteRouteTo( @origRoute );

$route = $msg->getRouteTo();
&testRouting( $route, @expected );  # sub defined just below # 11 - 14

#------------------------
# addRemoteRouteBack()

(@origRoute) = ("host","port",'call', 'service', 'event', "arg1","arg2");
(@expected)  = (@origRoute );
$msg->addRemoteRouteBack( @origRoute );

$route = $msg->getRouteBack();
&testRouting( $route, @expected );  # sub defined just below # 15 - 18

#------------------------
# Empty out the routings

$msg->delRouteTo();
$msg->delRouteTo();
$msg->delRouteBack();
$msg->delRouteBack();

is( $msg->hasRouting(), undef, "Is routing comlete?");       # 19

#------------------------
# TODO: more here

#------------------------
# methods not implemented
#
##my $mode = $msg->getMode( $msg->header() );
##is( $mode, "post", "Did addRouteTo('post'...) set mode correctly");  # 00

##my $ttl = $msg->getMode( $msg->header() );
##is( $mode, "post", "Did addRouteTo('post'...) set mode correctly");  # 00


#------------------------
# common subs

sub testRouting                # every time you call this, add "4" to "tests"
{   my($routing,@expected) = @_;

    like( $route, qr/^ARRAY/, "Is routing a ref?");              # a
    (@route) = (@$route);
    ok( @route, "Does msg have routing?");                       # b

    is( $#route, 6,        "Is routing num correct?");           # c
    is( @route, @expected, "Is routing list correct?");          # d

    return;
}
#########################

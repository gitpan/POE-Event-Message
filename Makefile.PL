# -*- Perl -*-
#
# File:  Makefile.PL
# Desc:  Make the makefile for POE::Event::Message and friends
# Date:  Sat Mar 17 14:21:32 2007
#
use inc::Module::Install;

name		'POE-Event-Message';
author		'Chris Cobb <nospamplease@ccobb.net>';
license 	'perl';
all_from	'lib/POE/Event/Message.pm';
tests		't/*/*/*.t t/*/*/*/*.t';

# When building this distribution
## no_index	directory 	=> 'eg';   #  no eg's just yet...
build_requires	Test::More	=> 0;

# Standard modules needed
requires	POSIX		=> 0;
requires	strict		=> 0;
requires	warnings	=> 0;

# Additional modules needed
# Note that POE.pm is not required by this class and
# Time::Hires is optional, but *highly* recommended!
## requires 	POE			=> n/a;

requires	POE::Driver::SysRW	=> 0;
requires	POE::Filter::Reference	=> 0;
requires 	Time::Hires		=> 0;

WriteAll();

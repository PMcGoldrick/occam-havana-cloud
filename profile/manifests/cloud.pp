###############################################################################
##                                                                           ##
## The MIT License (MIT)                                                     ##
##                                                                           ##
## Copyright (c) 2014 AT&T Inc.                                              ##
##                                                                           ##
## Permission is hereby granted, free of charge, to any person obtaining     ##
## a copy of this software and associated documentation files                ##
## (the "Software"), to deal in the Software without restriction, including  ##
## without limitation the rights to use, copy, modify, merge, publish,       ##
## distribute, sublicense, and/or sell copies of the Software, and to permit ##
## persons to whom the Software is furnished to do so, subject to the        ##
## conditions as detailed in the file LICENSE.                               ##
##                                                                           ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS   ##
## OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF                ##
## MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.    ##
## IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY      ##
## CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT ##
## OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR  ##
## THE USE OR OTHER DEALINGS IN THE SOFTWARE.                                ##
##                                                                           ##
###############################################################################
# == Class: profile::cloud
#
# Includes all the core configurations needed for an occam server.
# These includes:
#   - foundry users
#   - networking
#   - puppet agent
#   - firewall pre/post configurations
#
# === Parameters
#
# === Examples
#
# include profile::cloud
#
# === Authors
#
# Tomasz Z. Napierala <tnapierala@mirantis.com>
#
# === Copyright
#
# Copyright 2013 AT&T Foundry, unless otherwise noted.

class profile::cloud {

  include ::profile::routing::setup
  include profile::openstack::facts

  file { '/etc/libvirt/qemu/networks/autostart/default.xml':
    ensure => absent,
  }
  exec { 'stop default libvirt network':
    command     => 'virsh net-destroy default',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin' ],
    refreshonly => true,
    subscribe   => File['/etc/libvirt/qemu/networks/autostart/default.xml']
  }
}

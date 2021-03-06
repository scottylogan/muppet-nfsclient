# == Class: nfsclient
#
# Full description of class muppet_nfsclient here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'muppet_nfsclient':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class nfsclient {

  package { 'autofs':
    ensure => latest,
  }

  file { '/etc/auto.master':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => "puppet:///modules/${module_name}/auto.master",
    require => Package['autofs'],
    notify  => Service['autofs'],
  }

  file { '/etc/auto.home':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => "puppet:///modules/${module_name}/auto.home",
    require => Package['autofs'],
    notify  => Service['autofs'],
  }

  service { 'autofs':
    ensure   => 'running',
    name     => 'autofs.service',
    enable   => true,
    provider => 'systemd',
    require  => Package['autofs'],
  }
}

#!/bin/bash

rpmquery puppet --quiet && {
  exit 0
} || {
  yum -y localinstall http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
  yum -y install puppet-3.4.3 facter hiera
}

puppet module install 'puppetlabs/stdlib'
puppet module install 'stankevich/python'
puppet module install 'stahnma/epel'
puppet module install 'ajcrowe/supervisord'


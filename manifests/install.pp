# == Class graphiteapi::install
#
class graphiteapi::install {
  include graphiteapi::params

  # EPEL is needed for the packages.
  Package {
    require => [Class['epel'], Class['python']],
  }

  # @TODO: Decouple this a bit if possible.
  if (!defined(Class['python'])) {
    class { 'python':
      dev        => true,
      pip        => true,
      virtualenv => true,
    }
  }

  # Install some Graphite API dependencies.
  package { ['cairo-devel', 'libffi-devel', 'libyaml-devel']: } ->

  # Install graphite-api in a virtualenv.
  python::virtualenv { '/opt/graphite-api/':
    ensure  => present,
    version => 'system',
  } ->
  python::pip { 'graphite-api':
    virtualenv => '/opt/graphite-api/',
  } ->
  python::pip { 'gunicorn':
    virtualenv => '/opt/graphite-api/',
  }

  if $create_search_index == true {
    file { $graphiteapi_search_index:
      ensure => present,
      owner => $graphiteapi_user,
      group => $graphiteapi_group,
    }
  }
}

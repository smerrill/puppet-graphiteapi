# == Class graphiteapi::install
#
class graphiteapi::install {
  include graphiteapi::params

  # EPEL is needed for the packages.
  Package {
    require => Class['epel'],
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
  package { ['cairo-devel', 'libffi-devel', 'libyaml-devel', 'libtool']: } ->

  # Install graphite-api in a virtualenv.
  python::virtualenv { $graphiteapi::virtualenv_path:
    ensure  => present,
    version => 'system',
  }
  python::pip { 'graphite-api':
    virtualenv => $graphiteapi::virtualenv_path,
  } ->
  python::pip { 'gunicorn':
    virtualenv => $graphiteapi::virtualenv_path,
  }

  if $create_search_index == true {
    file { $graphiteapi_search_index:
      ensure => present,
      owner => $graphiteapi_user,
      group => $graphiteapi_group,
    }
  }
}

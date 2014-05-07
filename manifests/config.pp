# == Class graphite::config
#
# This class is called from graphite
#
class graphiteapi::config {
  file { '/etc/graphite-api.yaml':
    ensure  => present,
    owner   => $graphiteapi_user,
    group   => $graphiteapi_group,
    content => template('graphiteapi/graphite-api.yaml.erb'),
  }
}

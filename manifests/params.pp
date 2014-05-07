# == Class graphite::params
#
# This class is meant to be called from graphite
# It sets variables according to platform
#
class graphiteapi::params {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $graphiteapi_user  = 'nobody'
      $graphiteapi_group = 'nobody'
      $virtualenv_path = '/opt/graphite-api'
      $whisper_paths = ['/var/lib/carbon/whisper']
      $graphiteapi_tz = 'America/New_York'
      $graphiteapi_search_index = '/srv/graphiteapi_index'
      $create_search_index = true
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

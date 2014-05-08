# == Class graphite::service
#
# Run the graphite API via supervisord.
#
class graphiteapi::service {
  supervisord::program { 'graphite-api-gunicorn':
    command        => "${virtualenv_path}/bin/gunicorn -w2 --bind=127.0.0.1:8080 graphite_api.app:app",
    stdout_logfile => $graphiteapi_log_path,
    stderr_logfile => $graphiteapi_log_path,
    user           => $graphiteapi_user,
  }
}

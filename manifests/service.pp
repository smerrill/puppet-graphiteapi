# == Class graphite::service
#
# Run the graphite API via supervisord.
#
class graphiteapi::service {
  supervisord::program { 'graphite-api-gunicorn':
    command        => "${graphiteapi::virtualenv_path}/bin/gunicorn -w2 --bind=${graphiteapi::bind_addr}:${graphiteapi::bind_port} graphite_api.app:app",
    stdout_logfile => $graphiteapi_log_path,
    stderr_logfile => $graphiteapi_log_path,
    user           => $graphiteapi_user,
  }
}

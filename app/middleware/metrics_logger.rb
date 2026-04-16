class MetricsLogger
  def initialize(app) = @app = app
  def call(env)
    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    status, headers, body = @app.call(env)
    ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000).round
    Rails.logger.info(metric: :http, path: env["PATH_INFO"], status:, ms:)
    [ status, headers, body ]
  end
end

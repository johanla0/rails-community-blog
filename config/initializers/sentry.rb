# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://cfa42640668243febafe30ade84dc51a@o4505335392567296.ingest.sentry.io/4505335395516416'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.enabled_environments = %w[production]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end

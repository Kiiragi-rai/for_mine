require "sidekiq"
# require "sidekiq-scheduler"


Sidekiq.configure_server do |config|
  config.redis = { url: "redis://redis:6379" }

  schedule_file = Rails.root.join("config/schedule.yml")
Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://redis:6379" }
end

# require "sidekiq-scheduler/web"

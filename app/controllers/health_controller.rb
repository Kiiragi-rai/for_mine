class HealthController < ApplicationController
  def show
    # change "active" to "exec~~  F.E. get today "
    db_ok = ActiveRecord::Base.connection.active? rescue false
    redis_ok = Redis.new(url: ENV.fetch("REDIS_URL", "redis://redis:6379/1")).ping == "PONG" rescue false
    render json: { ok: db_ok && redis_ok, db: db_ok, redis: redis_ok }
  end
end

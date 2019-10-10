# Allow puma to be restarted by `rails restart` command.
before_fork do
  PumaWorkerKiller.config do |config|
    config.ram = Integer(ENV.fetch('MEMORY_AVAILABLE', 512))
  end
  PumaWorkerKiller.enable_rolling_restart
end

plugin :tmp_restart
plugin :heroku

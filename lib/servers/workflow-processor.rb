require 'kuroko2'

if Rails.env.development?
  ActionMailer::Base.logger = Kuroko2.logger
end

options = {
  worker_type: 'embedded',
  daemonize:   Rails.env.production?,
  log:         Rails.env.production? ? Rails.root.join("log/workflow-processor.log").to_s : $stdout,
  log_level:   Rails.env.production? ? :info : :debug,
  pid_path:    Rails.root.join('tmp/pids/workflow-processor.pid').to_s,
  supervisor:  Rails.env.production?,
}

server = ServerEngine.create(nil, Workflow::Processor, options)
server.run

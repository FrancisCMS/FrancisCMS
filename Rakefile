require 'bundler/setup'

require 'rubocop/rake_task'

load 'rails/tasks/statistics.rake'

Bundler::GemHelper.install_tasks

RuboCop::RakeTask.new do |task|
  task.fail_on_error = false
end

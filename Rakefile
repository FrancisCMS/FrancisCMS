require 'bundler/setup'
require 'rubocop/rake_task'

load 'rails/tasks/statistics.rake'

Bundler::GemHelper.install_tasks
RuboCop::RakeTask.new

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

task default: :spec

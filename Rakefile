require 'rspec/core/rake_task'

begin
    RSpec::Core::RakeTask.new(:spec)
    task :default => :spec
rescue LoadError
end
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:run_tests) do |t|
  t.pattern = 'sample_spec.rb'
  t.rspec_opts = '--format progress --format RspecJunitFormatter --out reports/results.xml'
end

task default: :run_tests
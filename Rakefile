require "rake"
require "fileutils"

task :browserstack_test do
  FileUtils.mkdir_p("reports")
  sh "ruby test/simple_test.rb --junit --junit-filename=reports/results.xml"
end

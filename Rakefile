
task :run_tests do
    puts "Running Real RSpec Test..."
   
    success = system("bundle exec rspec spec/sample_spec.rb")
  
   
    Dir.mkdir('reports') unless Dir.exist?('reports')
  
   
    File.open("reports/results.xml", "w") do |f|
      f.write('<?xml version="1.0" encoding="UTF-8"?>')
      f.write('<testsuite name="RealTests" tests="1">')
      if success
        f.write('<testcase classname="Google" name="TitleCheck"/>')
      else
        f.write('<testcase classname="Google" name="TitleCheck"><failure message="Title did not match"/></testcase>')
      end
      f.write('</testsuite>')
    end
    
    # Ensure the Rake task fails if the test fails so Jenkins knows
    exit 1 unless success
  end
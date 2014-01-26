namespace :test do
  require 'rspec/core/rake_task'

  def with_thin(try = 0, max = 100)
    require 'http'
    thinpid = spawn("bin/thin start")
    begin
      $stderr.print '.'
      Http.head "http://127.0.0.1:3000/"
    rescue Errno::ECONNREFUSED
      sleep(0.2)
      retry if (try += 1) < max
      raise
    end
    yield
  ensure
    Process.kill("SIGKILL", thinpid) if thinpid
  end

  desc "Run Unit tests"
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern    = "test/unit/**/test_*.rb"
    t.rspec_opts = %w[ --color -Ilib -Itest/unit ]
  end

  desc "Run Cucumber tests"
  task(:cucumber) do
    system('bin/cucumber test/acceptance')
  end

  desc "Run Acceptance tests"
  task(:acceptance) do
    with_thin {
      system('bin/cucumber test/acceptance')
    }
  end

end
task :test => [:"test:unit", :"test:acceptance"]

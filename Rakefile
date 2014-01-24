$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'pipas_persister'

#
# Install all tasks found in tasks folder
#
# See .rake files there for complete documentation.
#
Dir["tasks/*.rake"].each do |taskfile|
  load taskfile
end

# We run tests by default
task :default => :test

require 'uuid'
require 'path'
require 'time'
require 'pg'
require 'sequel'

require_relative 'ext/datetime'

require 'alf'
require_relative 'ext/alf/detail'

module PipasPersister

  # Only use ruby's DateTime class and hide Time one
  Time = ::Sequel.datetime_class = ::DateTime

  # Version of the software component
  VERSION = "0.1"

  # Root folder of this software component
  ROOT_FOLDER = Path.backfind('.[Gemfile]') or raise("Missing Gemfile")

  # Folder containing configuration files
  CONFIG_FOLDER = ROOT_FOLDER/'config' or raise("Missing config folder")

  # Folder containing seed datasets
  SEEDS_FOLDER = ROOT_FOLDER/'seeds' or raise("Missing seeds folder")

  # In what environment does the component run 
  ENVIRONMENT = ENV['PIPAS_ENV'] || ENV['RACK_ENV'] || "development"

  # Database configuration file, if any (e.g. no such one one heroku)
  DATABASE_CONFIG_FILE = CONFIG_FOLDER/'database.yml'

  # What database configuration to use
  DATABASE_CONFIG = ENV['DATABASE_URL'] \
                 || (DATABASE_CONFIG_FILE.exists? && DATABASE_CONFIG_FILE.load[ENVIRONMENT]) \
                 || raise("Unable to find database configuration under `#{ENVIRONMENT}`")

  # Sequel database object (for connection pooling)
  SEQUEL_DATABASE = ::Sequel.connect(DATABASE_CONFIG)

  # Alf database object
  ALF_DATABASE = ::Alf.database(SEQUEL_DATABASE)

end # module PipasPersister
require_relative 'pipas_persister/viewpoints'
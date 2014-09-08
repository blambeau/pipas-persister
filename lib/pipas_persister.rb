# STDLIB
require 'forwardable'
require 'time'
require 'base64'
require 'digest/sha1'

# THIRD-PARTY GEMS
require 'uuid'
require 'path'
require 'pg'
require 'sequel'
require 'tilt'
require 'wlang'
require 'kramdown'
require 'alf'
require 'json'

# MONKEY PATCHING
require_relative 'ext/datetime'
require_relative 'ext/alf/detail'

# Sequel database object (for connection pooling)
require 'logger'

module PipasPersister

  # Only use ruby's DateTime class and hide Time one
  Time = ::Sequel.datetime_class = ::DateTime

  # We use Time + offset for simulation only
  @@offset = 0

  def self.nextDay
    @@offset = @@offset + 1
    puts @@offset
  end

  def self.getSimulationTime
    Time.now + @@offset
  end

  # Version of the software component
  VERSION = "0.5.2"

  # Root folder of this software component
  ROOT_FOLDER = Path.backfind('.[Gemfile]') or raise("Missing Gemfile")

  # Folder containing configuration files
  CONFIG_FOLDER = ROOT_FOLDER/'config' or raise("Missing config folder")

  # Folder containing seed datasets
  SEEDS_FOLDER = ROOT_FOLDER/'seeds' or raise("Missing seeds folder")

  # Folder containing resource definitions
  RESOURCES_FOLDER = ROOT_FOLDER/'resources' or raise("Missing resources folder")

  # Folder containing sinatra views
  VIEWS_FOLDER = ROOT_FOLDER/'views' or raise("Missing views folder")

  # In what environment does the component run 
  ENVIRONMENT = ENV['PIPAS_ENV'] || ENV['RACK_ENV'] || "development"

  # Database configuration file, if any (e.g. no such one one heroku)
  DATABASE_CONFIG_FILE = CONFIG_FOLDER/'database.yml'

  # What database configuration to use
  DATABASE_CONFIG = ENV['DATABASE_URL'] \
                 || (DATABASE_CONFIG_FILE.exists? && DATABASE_CONFIG_FILE.load[ENVIRONMENT]) \
                 || raise("Unable to find database configuration under `#{ENVIRONMENT}`")

#  DATABASE_CONFIG.merge!(:loggers => [ Logger.new(STDOUT) ])

  # Sequel database object (for connection pooling)
  SEQUEL_DATABASE = ::Sequel.connect(DATABASE_CONFIG)

  # Alf database object
  ALF_DATABASE = ::Alf.database(SEQUEL_DATABASE)

  # UUID
  UUID_GENERATOR = ::UUID.new

end # module PipasPersister

# FRAMEWORK
require_relative 'pipas_persister/errors'
require_relative 'pipas_persister/seeder'
require_relative 'pipas_persister/resource'
require_relative 'pipas_persister/operation'

# INSTANTIATION
require_relative 'pipas_persister/viewpoints'
require_relative 'pipas_persister/operations'

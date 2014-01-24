require 'path'
require 'sequel'
require 'alf'

namespace :db do

  PIPAS_ENV = "devel"
  ROOT      = Path.dir.parent
  DB_CONFIG = (ROOT/"config/database.yml").load[PIPAS_ENV]
  SEQUEL_DB = ::Sequel.connect(DB_CONFIG)
  DB        = Alf::Database.new(SEQUEL_DB)

  def pg_cmd(cmd)
    "#{cmd}"
  end

  def shell(*cmds)
    cmd = cmds.join("\n")
    puts cmd
    system cmd
  end

  def seed(from)
    folder = ROOT/"seeds/#{from}"

    # load metadata and install parent dataset if any
    metadata = (folder/"metadata.json").load
    if parent = metadata["inherits"]
      seed(parent)
    end

    # load files in order
    files = folder.glob("*.json").reject{|f| f.basename.to_s =~ /^metadata/ }.sort
    names = files.map{|f|
      f.basename.rm_ext.to_s[/^\d+-(.*)/, 1].gsub(/-/, '_')
    }
    pairs = files.zip(names)

    # Truncate tables then fill them
    puts "--- Seeding `#{from}`"
    DB.connect do |conn|
      names.reverse.each do |name|
        puts "Removing from #{name}"
        conn.relvar(name).delete
      end
      pairs.each do |file, name|
        puts "Seeding #{name}"
        conn.relvar(name).affect(file.load)
      end
    end
  end

  desc "Drops the database (USE WITH CARE)"
  task :drop do
    shell pg_cmd("dropdb #{DB_CONFIG['database']}"),
          pg_cmd("dropuser #{DB_CONFIG['user']}")
  end

  desc "Create an fresh new database (USE WITH CARE)"
  task :create => :drop do
    shell pg_cmd("createuser --no-createdb --no-createrole --no-superuser --no-password #{DB_CONFIG['user']}"),
          pg_cmd("createdb --owner=#{DB_CONFIG['user']} #{DB_CONFIG['database']}")
  end

  desc "Run migrations on the current database"
  task :migrate do
    Sequel.extension :migration
    Sequel::Migrator.apply(SEQUEL_DB, Path.dir.parent/"migrations")
  end

  desc "Seed the database (USE WITH CARE)"
  task :seed, :from do |t,args|
    seed(args[:from] || 'initial-state')
  end

  desc "Rebuild the database (USE WITH CARE)"
  task :rebuild, :from do |t,args|
    seed(args[:from] || 'initial-state')
  end
  task :rebuild => [ :create, :migrate ]

end

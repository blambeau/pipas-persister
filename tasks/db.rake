namespace :db do
  ROOT      = PipasPersister::ROOT_FOLDER
  DB_CONFIG = PipasPersister::DATABASE_CONFIG
  SEQUEL_DB = PipasPersister::SEQUEL_DATABASE

  def pg_cmd(cmd)
    "#{cmd}"
  end

  def shell(*cmds)
    cmd = cmds.join("\n")
    puts cmd
    system cmd
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
    PipasPersister::Seeder.call(args[:from] || 'initial-state')
  end

  desc "Rebuild the database (USE WITH CARE)"
  task :rebuild, :from do |t,args|
    PipasPersister::Seeder.call(args[:from] || 'initial-state')
  end
  task :rebuild => [ :create, :migrate ]

end

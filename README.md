# PIPAS persister

This repository provides an implementation of the PIPAS Persister, its
PostgreSQL database and RESTful interface.

A test deployment runs on the [Heroku cloud platform](https://heroku.com/).
The application can be reached at http://pipas-persister.herokuapp.com/

## Project structure

    /config      private configuration files on specific deployments
    /lib         ruby code of the logical database facade and RESTful interface
    /migrations  database migrations files (managed by Sequel)
    /seeds       definition of test datasets
    /tasks       Rake tasks (e.g. test:unit, db:migrate)
    /test        Unit and acceptance tests

Developers of other PIPAS components are invited to read the cucumber specs
for a description of the implemented features (see test/acceptance/*.features)
here.

## Implemented services so far

    GET /scheduling/problem   get the current scheduling problem to solve

## How to install?

* Make sure that you have a recent PostgreSQL (>= 9.2)
* Make sure that you have a recent ruby (>= 1.9.3)
* Make sure that you have the 'bundler' gem installed (`gem install bundler`)

### Cloning the project and installing dependencies

```
git clone https://github.com/blambeau/pipas-persister.git
cd pipas-persister
bundle install --bin-stubs
```

### Installing the database

* Make sure that postgresql administration tools are available (`dropuser`,
  `createuser`, `dropdb`, `createdb`)
* Make sure the current user may use them without providing a password
  (otherwise, see tasks/db.rake and change the `pg_cmd` method, for instance
   to use `sudo su postgres -c '...'`)

```
bin/rake db:rebuild
```

### Seeding the database with a particular dataset

* Provided you succeeded with 'Installing the database'

```
bin/rake db:seed[initial-state]
```

Change `initial-state` with the name of the dataset that you want to install
(see subfolders of /seeds).

### Migrating the database schema

* Provided you succeeded with 'Installing the database'

```
bin/rake db:migrate
```

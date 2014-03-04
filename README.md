# PIPAS persister

This repository provides an implementation of the PIPAS Persister, its
PostgreSQL database and RESTful interface.

A test deployment runs on the [Heroku cloud platform](https://heroku.com/).
The application can be reached at http://pipas-persister.herokuapp.com/

## Services implemented so far

Please see the complete list with documentation at [/resources/](/resources/).

    GET  /scheduling/problem   get the current scheduling problem to solve
    GET  /scheduling/solution  get the current solution to the scheduling problem
    PUT  /scheduling/solution  update the current scheduling solution
    GET  /patients/            get the list of registered patients
    GET  /appointments/{uuid}  get information about a specific appointment
    PUT  /appointments/{uuid}  update information about an appointment
    GET  /deliveries/{uuid}    get information about a specific delivery
    POST /deliveries/          add information about a new delivery

## Project structure

    /config      private configuration files on specific deployments
    /lib         ruby code of the logical database facade and RESTful interface
    /migrations  database migrations files (managed by Sequel)
    /resources   formal description of RESTful resources
    /seeds       definition of test datasets
    /tasks       Rake tasks (e.g. test:unit, db:migrate)
    /test        Unit and acceptance tests
    /views       WLang views used for documentation generation

## Overview of Rake tasks

    test              Run all tests
    test:unit         Run unit tests only
    test:acceptance   Run acceptance tests only

    db:drop           Remove the database and database user
    db:create         Create the database (empty) and its user
    db:seed[from]     Install particular seeds (defaults to 'initial-state')
    db:migrate        Run migrations to use the latest schema
    db:rebuild        Rebuild the database from scratch (create + migrate + seed)

## How to install?

#### Dependencies

* Make sure that you have a recent PostgreSQL (>= 9.2)
* Make sure that you have a recent ruby (>= 1.9.3)
* Make sure that you have the 'bundler' gem installed (`gem install bundler`)

#### Cloning the project and installing dependencies

    git clone https://github.com/blambeau/pipas-persister.git
    cd pipas-persister
    bundle install --bin-stubs

#### Installing the database

* Make sure that postgresql administration tools are available (`dropuser`,
  `createuser`, `dropdb`, `createdb`)
* Make sure the current user may use them without providing a password
  (otherwise, see tasks/db.rake and change the `pg_cmd` method, for instance
   to use `sudo su postgres -c '...'`)
* Copy `config/database.example.yml` to `config/database.yml` and update to
  match your configuration

Then, and only then,

    bin/rake db:rebuild

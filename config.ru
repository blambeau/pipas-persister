$:.unshift File.expand_path('../lib', __FILE__)
require 'pipas_persister'
require 'pipas_persister/service'
run PipasPersister::Service::INSTANCE
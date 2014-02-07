$:.unshift File.expand_path('../../../../lib', __FILE__)
require 'json'
require 'http'
require 'time'
require 'pipas_persister'

def client
  @client ||= Client.new
end
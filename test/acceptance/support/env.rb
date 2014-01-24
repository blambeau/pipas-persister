$:.unshift File.expand_path('../../../../lib', __FILE__)
require 'json'
require 'http'

def client
  @client ||= Client.new
end
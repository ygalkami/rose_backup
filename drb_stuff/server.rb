#!/usr/bin/env ruby -w
# simple_service.rb
# A simple DRb service

# load DRb
require 'drb'
require 'rinda/tuplespace'

# start up the DRb service

DRb.start_service nil, Rinda::TupleSpace.new

# We need the uri of the service to connect a client
puts DRb.uri

# wait for the DRb service to finish before exiting
DRb.thread.join

#!/usr/bin/env ruby -w
# simple_service.rb
# A simple DRb service

# load DRb
require 'drb'
require 'rinda/tuplespace'

# start up the DRb service

DRb.start_service 'druby://137.112.147.92:1234', {}

# We need the uri of the service to connect a client
puts DRb.uri

# wait for the DRb service to finish before exiting
DRb.thread.join

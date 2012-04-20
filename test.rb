require 'rinda/tuplespace'

ts = Rinda::TupleSpace.new

DRb.start_service('druby://137.112.147.92:1234', ts)

DRb.thread.join

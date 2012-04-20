class Database < ActiveRecord::Base
  validates_presence_of :name
	validates_length_of :name, :minimum => 4
		
	has_many :tables
end

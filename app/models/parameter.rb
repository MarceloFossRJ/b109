class Parameter < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :description, :name, :parameter_type, :value
  
  validates_presence_of :description, :name, :parameter_type, :value
  validates_uniqueness_of :name
  
end

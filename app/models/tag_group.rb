class TagGroup < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name
  
  has_many :tags
  
  validates_presence_of :name
  validates_length_of :name, :within => 3..80
  validates_uniqueness_of :name
end

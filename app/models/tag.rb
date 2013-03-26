class Tag < ActiveRecord::Base
  has_paper_trail
    
  attr_accessible :tag_group_id

  belongs_to :tag_group
  belongs_to :taggable, :polymorphic => true
  #has_many :tags, :as => :taggable
  
  
  validates_presence_of :tag_group_id
  
end

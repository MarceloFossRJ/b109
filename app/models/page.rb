class Page < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :category
  belongs_to :user
  
  has_many :tags, :as => :taggable, :dependent => :destroy
  accepts_nested_attributes_for :tags, :allow_destroy => true
  
  attr_accessible :content, :is_published, :title, :category_id, :user_id

  validates_presence_of :title, :content, :user_id
  validates_length_of :title, :within => 3..80
  validates_uniqueness_of :title  
end

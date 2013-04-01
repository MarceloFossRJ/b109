class Post < ActiveRecord::Base
  has_paper_trail
  attr_accessible  :title, :content, :is_published, :user_id, :category_id, :preview
  
  belongs_to :user
  belongs_to :category
  
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :comments, :allow_destroy => true
  
  has_many :tags, :as => :taggable, :dependent => :destroy
  accepts_nested_attributes_for :tags, :allow_destroy => true
  
  attr_accessible :content, :is_published, :title, :user_id

  validates_presence_of :title, :content, :user_id
  validates_length_of :title, :within => 3..80
  validates_uniqueness_of :title
    
end

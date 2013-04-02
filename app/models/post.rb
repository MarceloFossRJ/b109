class Post < ActiveRecord::Base
  has_paper_trail
  attr_accessible  :title, :content, :is_published, :user_id, :category_id, :preview, :tags, :tags_attributes
  
  belongs_to :user
  belongs_to :category
  
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :comments, :allow_destroy => true
  
  has_many :tags, :as => :taggable, :dependent => :destroy
  accepts_nested_attributes_for :tags, reject_if:lambda { |attrs| attrs.all? { |key, value| value.blank? } }, :allow_destroy => true
  
  attr_accessible :content, :is_published, :title, :user_id

  validates_presence_of :title, :content, :user_id, :preview
  validates_length_of :title, :within => 3..80
  validates_uniqueness_of :title
  
  def with_blank_tag
    tags.build
    self
  end  
end

class Image < ActiveRecord::Base
  attr_accessible :media, :name, :user_id
  
  belongs_to :user
  
  mount_uploader :media, MediaUploader
  
  validates_presence_of :name, :user_id, :media
  validates_uniqueness_of :name
  validates_length_of :name, :within => 3..80
  
end

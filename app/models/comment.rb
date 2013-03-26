class Comment < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :comment, :post_id, :user_id
  
  belongs_to :posts
  belongs_to :users
  
  validates_presence_of :user_id
  validates_presence_of :post_id
  validates_presence_of :comment
end

class Comment < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :comment, :post_id, :user_id
  
  belongs_to :post
  belongs_to :user
  
  validates_presence_of :user_id
  validates_presence_of :post_id
  validates_presence_of :comment
  

end

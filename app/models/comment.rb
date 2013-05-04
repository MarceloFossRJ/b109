class Comment < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :comment, :post_id, :user_id, :is_published, :is_validated
  
  belongs_to :post
  belongs_to :user
  
  validates_presence_of :user_id
  validates_presence_of :post_id
  validates_presence_of :comment
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |u|
        csv << u.attributes.values_at(*column_names)
      end
    end
  end

end

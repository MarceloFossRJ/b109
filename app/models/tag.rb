class Tag < ActiveRecord::Base
  has_paper_trail
    
  attr_accessible :tag_group_id

  belongs_to :tag_group
  belongs_to :taggable, :polymorphic => true
  #has_many :tags, :as => :taggable
  
  
  validates_presence_of :tag_group_id
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |u|
        csv << u.attributes.values_at(*column_names)
      end
    end
  end
  
end

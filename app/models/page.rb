class Page < ActiveRecord::Base
  has_paper_trail
  attr_accessible :content, :is_published, :title, :category_id, :user_id, :tags, :tags_attributes
    
  belongs_to :category
  belongs_to :user
  
  has_many :tags, :as => :taggable, :dependent => :destroy
  accepts_nested_attributes_for :tags, reject_if:lambda { |attrs| attrs.all? { |key, value| value.blank? } }, :allow_destroy => true
 
  validates_presence_of :title, :content, :user_id
  validates_length_of :title, :within => 3..80
  validates_uniqueness_of :title  
  
  def with_blank_tag
    tags.build
    self
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |u|
        csv << u.attributes.values_at(*column_names)
      end
    end
  end
  
end

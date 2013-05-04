class Parameter < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :description, :name, :group, :value
  
  validates_presence_of :name, :group, :value
  validates_uniqueness_of :name

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |u|
        csv << u.attributes.values_at(*column_names)
      end
    end
  end

  
  def self.records_per_page
    u=Parameter.find_by_name('records_per_page')
    return u.value.to_i
  end

  def self.application_title
    u=Parameter.find_by_name('application_title')
    return u.value.to_s
  end
  
  def self.root_page
    u=Parameter.find_by_name('root_page')
    return u.value.to_s
  end

  def self.posts_per_page
    u=Parameter.find_by_name('posts_per_page')
    return u.value.to_i
  end
  
  def self.users_can_add_comment
    u=Parameter.find_by_name('users_can_add_comment')
    return u.value.to_s
  end

  def self.comments_published_automatically
    u=Parameter.find_by_name('comments_published_automatically')
    return u.value.to_s
  end

############

  def self.linkedin_authentication
    u=Parameter.find_by_name('linkedin_authentication')
    return u.value.to_i
  end

  def self.github_authentication
    u=Parameter.find_by_name('github_authentication')
    return u.value.to_i
  end

  def self.gmail_authentication
    u=Parameter.find_by_name('gmail_authentication')
    return u.value.to_i
  end

  def self.facebook_authentication
    u=Parameter.find_by_name('facebook_authentication')
    return u.value.to_i
  end


end

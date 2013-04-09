class AddIsPublishedToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :is_published, :boolean
    add_column :comments, :is_validated, :boolean
  end

  def self.down
    remove_column(:comments, :is_published)
    remove_column(:comments, :is_validated)
  end
end

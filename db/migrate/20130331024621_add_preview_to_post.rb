class AddPreviewToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :preview, :text
  end

  def self.down
    remove_column(:posts, :preview)
  end
end

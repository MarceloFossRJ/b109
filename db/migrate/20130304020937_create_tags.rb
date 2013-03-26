class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :tag_group_id
      t.integer :taggable_id
      t.string :taggable_type

      t.timestamps
    end
  end
end

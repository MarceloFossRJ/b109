class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.string :media
      t.references :user

      t.timestamps
    end
  end
end

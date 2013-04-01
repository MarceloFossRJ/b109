class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.references :page
      t.boolean :is_active
      t.integer :menu_id
      t.integer :menu_type
      t.integer :menu_order

      t.timestamps
    end
    add_index :menus, :page_id
  end
end

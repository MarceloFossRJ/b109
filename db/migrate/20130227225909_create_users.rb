class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :login
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.boolean :is_admin
      t.boolean :is_active
      t.integer :wrong_login_attempts
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end

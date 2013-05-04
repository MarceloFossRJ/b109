class AddParameterGroup < ActiveRecord::Migration
  def up
    add_column :parameters, :group, :string
  end

  def down
    remove_column(:parameters, :group)
  end
end

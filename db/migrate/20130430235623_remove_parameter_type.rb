class RemoveParameterType < ActiveRecord::Migration
  def up
    remove_column(:parameters, :parameter_type)
  end

  def down
    add_column :parameters, :parameter_type, :string
  end
end

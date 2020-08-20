class AddTypeToBoxes < ActiveRecord::Migration[6.0]
  def change
    add_column :boxes, :type, :string
  end
end

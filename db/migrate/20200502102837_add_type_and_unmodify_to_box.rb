class AddTypeAndUnmodifyToBox < ActiveRecord::Migration[6.0]
  def change
    add_column :boxes, :box_type, :string
    add_column :boxes, :deck_name, :string
    add_column :boxes, :leave_box_in_tact, :boolean
  end
end
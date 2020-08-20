class AddUserToBoxes < ActiveRecord::Migration[6.0]
  def change
    Box.destroy_all
    add_reference :boxes, :user, foreign_key: true
    change_column :boxes, :user_id, :integer, null: false
  end
end
class AddDefaultToBoxtype < ActiveRecord::Migration[6.0]
  def change
    change_column :boxes, :box_type, :string, :default => "Storage Box"
  end
end

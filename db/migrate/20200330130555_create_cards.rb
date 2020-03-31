class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.boolean :foil
      t.string :set
      t.references :box, foreign_key: true

      t.timestamps
    end
  end
end

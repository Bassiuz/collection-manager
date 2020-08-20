class CreateCardInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :card_infos do |t|
      t.string :image_url
      t.string :scryfall_id
      t.decimal :price
      t.string :name

      t.timestamps
    end
  end
end

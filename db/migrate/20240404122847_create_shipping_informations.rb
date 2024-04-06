class CreateShippingInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_informations do |t|
      t.references :order, null: false, foreign_key: true
      t.string :post_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :block_number, null: false
      t.string :building_name
      t.string :telephone_number, null: false
      t.timestamps
    end
  end
end

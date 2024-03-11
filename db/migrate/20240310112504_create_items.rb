class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|

      # t.timestamps
      t.integer :category_id,null: false
      t.integer :condition_id,null: false
      t.integer :shipping_charge_id,null: false 
      t.integer :prefecture_id,null: false
      t.string :item_name,null: false
      t.integer :price,null: false
      t.text :information, null: false
      t.integer :delivaly_day_id,null: false


    end
  end
end

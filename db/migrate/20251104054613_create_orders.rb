class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :postal_code
      t.integer :prefecture_id
      t.string :city
      t.string :address
      t.string :detail_address
      t.string :phone
      t.references :purchase_management, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateTalents < ActiveRecord::Migration[6.0]
  def change
    create_table :talents do |t|
      t.string :name, null: false
      t.string :email, null: false, index: true, unique: true
      t.string :mobile_phone, null: false, index: true, unique: true

      t.timestamps
    end
  end
end

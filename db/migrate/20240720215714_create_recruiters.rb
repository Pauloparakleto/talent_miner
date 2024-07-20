class CreateRecruiters < ActiveRecord::Migration[6.0]
  def change
    create_table :recruiters do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true, index: true
      t.string :password, null: false

      t.timestamps
    end
  end
end
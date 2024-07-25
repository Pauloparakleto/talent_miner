class CreateTablePublicSubmission < ActiveRecord::Migration[6.0]
  def change
    create_table :public_submissions do |t|
      t.references :talent
      t.references :job

      t.timestamps
    end
  end
end

class CreateRecruiterJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :recruiter_jobs do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.date :start_date
      t.date :end_date
      t.integer :status, default: 0, index: true
      t.jsonb :skills
      t.references :recruiter, null: false, foreign_key: true

      t.timestamps
    end
  end
end

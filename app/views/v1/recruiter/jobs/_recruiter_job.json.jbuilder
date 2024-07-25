json.id recruiter_job.id if recruiter_job.persisted?

json.extract! recruiter_job, :title, :description, :start_date, :end_date, :status, :skills, :recruiter_id, :created_at, :updated_at

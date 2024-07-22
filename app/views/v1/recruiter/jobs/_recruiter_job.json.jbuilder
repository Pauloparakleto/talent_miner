json.extract! recruiter_job, :id, :title, :description, :start_date, :end_date, :status, :skills, :recruiter_id, :created_at, :updated_at
json.url recruiter_job_url(recruiter_job, format: :json)

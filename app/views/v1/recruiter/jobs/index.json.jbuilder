json.cache! ['job', @recruiter_jobs], expires_in: 5.minutes do
 json.array! @recruiter_jobs, partial: "recruiter/jobs/recruiter_job", as: :recruiter_job
end

json.id submission.id if submission.persisted?

json.extract! submission, :title, :description, :start_date, :end_date, :status, :skills

json.job do
  json.id submission.job.id
end

json.talent do
  json.id submission.talent.id
  json.name submission.name
  json.mobile_phone submission.mobile_phone
  json.email submission.email
end

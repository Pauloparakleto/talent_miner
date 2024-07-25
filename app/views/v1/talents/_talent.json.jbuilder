json.extract! talent, :id, :name, :email, :mobile_phone, :created_at, :updated_at
json.file_url rails_blob_url(talent.resume, disposition: "attachment") if talent.resume.attached?


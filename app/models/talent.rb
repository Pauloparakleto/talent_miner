class Talent < ApplicationRecord
  validates_presence_of :name, :mobile_phone, :email
end

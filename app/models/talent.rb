class Talent < ApplicationRecord
  has_one_attached :resume

  validates_presence_of :name, :mobile_phone, :email
end

require 'spec_helper'

shared_context 'with Talent' do
  let(:talent) do
    Talent.create(talent_attributes)
  end

  let(:talent_attributes) do
    {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      mobile_phone: Faker::PhoneNumber.cell_phone
    }
  end
end

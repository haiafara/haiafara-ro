FactoryBot.define do
  factory :region do
    sequence :name do |n|
      "Test Region #{n}"
    end
  end
end
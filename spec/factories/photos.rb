FactoryBot.define do
  factory :photo do
    sequence :name do |n|
      "Test Photo #{n}"
    end
    sequence :description do |n|
      "Test Description #{n}"
    end
    image { File.open('support/haiafara-screenshot.png') }
    photoable { nil }
  end
end

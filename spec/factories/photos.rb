FactoryBot.define do
  factory :photo do
    name { "MyString" }
    description { "MyText" }
    image { File.open('support/haiafara-screenshot.png') }
    photoable { nil }
  end
end

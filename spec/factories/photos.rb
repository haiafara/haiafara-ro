FactoryBot.define do
  factory :photo do
    name { "MyString" }
    description { "MyText" }
    image_data { "MyText" }
    photoable { nil }
  end
end

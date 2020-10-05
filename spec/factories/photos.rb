# frozen_string_literal: true

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

    trait :with_description_html do
      sequence :description_html do |n|
        "Test Photo Description HTML #{n}"
      end
    end
  end
end

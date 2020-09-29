# frozen_string_literal: true

FactoryBot.define do
  factory :poi do
    sequence :name do |n|
      "Test POI #{n}"
    end
    sequence :description do |n|
      "Test POI Description #{n}"
    end
    trait :with_zones do
      transient do
        zone_count { 1 }
      end
      zones do
        Array.new(zone_count, build(:zone))
      end
    end
    trait :point do
      shape do
        '0020000001000010e64037b33d07c84b5e4047d5ef73c0c1fd'
      end
    end
    trait :with_description_html do
      sequence :description_html do |n|
        "Test POI Description HTML #{n}"
      end
    end
  end
end

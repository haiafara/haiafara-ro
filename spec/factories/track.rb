# frozen_string_literal: true

require_relative '../support/line_strings'

FactoryBot.define do
  factory :track do
    sequence :name do |n|
      "Test Track #{n}"
    end

    sequence :description do |n|
      "Test Track Description #{n}"
    end

    trait :with_zones do
      transient do
        zone_count { 1 }
      end

      zones do
        Array.new(zone_count, build(:zone))
      end
    end

    trait :three_points do
      shape do
        Support::LineStrings::ThreePoints
      end
    end
  end
end

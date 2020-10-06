# frozen_string_literal: true

FactoryBot.define do
  factory :zone do
    sequence :name do |n|
      "Test Zone #{n}"
    end

    sequence :description do |n|
      "Test Zone Description #{n}"
    end

    region

    bounding_box do
      '0103000020E610000001000000050000002506819543AB3740' \
      '3333333333D347409A99999999B937403333333333D347409A' \
      '99999999B9374083C0CAA145D647402506819543AB374083C0' \
      'CAA145D647402506819543AB37403333333333D34740'
    end

    trait :with_description_html do
      sequence :description_html do |n|
        "Test Zone Description HTML #{n}"
      end
    end
  end
end

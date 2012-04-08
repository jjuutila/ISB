FactoryGirl.define do
  factory :season do
    sequence(:division) {|n| "#{n}. divisioona" }
    history Faker::Lorem.paragraph(1)
    state "active"
    association :section
    sequence(:start_year, 2010) {|n| n }
  end
end
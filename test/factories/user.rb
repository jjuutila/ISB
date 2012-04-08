FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) {|n| "person#{n}@example.com" }
    password 'salainensana'
    password_confirmation 'salainensana'
  end
end
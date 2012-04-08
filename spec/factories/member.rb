FactoryGirl.define do
  factory :member do
    first_name {Faker::Name.first_name()}
    last_name {Faker::Name.last_name()}
    gender [true, false].sample
    number {rand(100)}
    position {rand(3)}
    all_time_assists {rand(1000)}
    all_time_goals {rand(1000)}
    birth_year {rand(20) + 1980}
    shoots nil
  end
end

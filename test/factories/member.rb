Factory.define :member do |m|
  m.first_name {Faker::Name.first_name()}
  m.last_name {Faker::Name.last_name()}
  m.gender [true, false].sample
  m.number {rand(100)}
  m.position {rand(3)}
  m.all_time_assists rand(1000)
  m.all_time_goals rand(1000)
  m.birth_year rand(20) + 1980
  m.shoots nil
end

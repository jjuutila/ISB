Factory.define :user do |f|
  f.first_name { Faker::Name.first_name }
  f.last_name { Faker::Name.last_name }
  f.sequence(:email) {|n| "person#{n}@example.com" }
  f.password 'salainensana'
  f.password_confirmation 'salainensana'
end
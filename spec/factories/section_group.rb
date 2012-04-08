FactoryGirl.define do
  factory :section_group do
    name {Faker::Lorem.words(2).join(" ")}
    slug {Faker::Lorem.words(2).join("-").downcase}
    are_players_male true
  end
end

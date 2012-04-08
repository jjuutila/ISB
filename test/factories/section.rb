FactoryGirl.define do
  factory :section do
    name {Faker::Lorem.words(2).join(" ")}
    slug {Faker::Lorem.words(2).join("-").downcase}
    group { FactoryGirl.build :section_group }
    picasa_user_id { Faker::Lorem.words(1) }
  end
end
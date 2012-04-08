FactoryGirl.define do
  factory :news, :class => News do
    title Faker::Lorem.words(2).join(" ")
    content Faker::Lorem.paragraph(4)
  end
end


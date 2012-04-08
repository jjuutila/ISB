FactoryGirl.define do
  factory :comment do
    title Faker::Lorem.words(3).join(" ")
    content Faker::Lorem.paragraph(3)
    author Faker::Name.name
    email Faker::Internet.email
    honeypot Comment::HONEYPOT_SECRET
  end
end

Factory.define :comment, :class => Comment do |c|
  c.title Faker::Lorem.words(3).join(" ")
  c.content Faker::Lorem.paragraph(3)
  c.author Faker::Name.name
  c.email Faker::Internet.email
  c.honeypot Comment::HONEYPOT_SECRET
end

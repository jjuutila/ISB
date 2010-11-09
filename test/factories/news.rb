Factory.define :news, :class => News do |n|
  n.title Faker::Lorem.words(2).join(" ")
  n.content Faker::Lorem.paragraph(4)
end


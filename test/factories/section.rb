Factory.define :section do |f|
  f.slug Faker::Lorem.words(2).join("-").downcase
  f.name Faker::Lorem.words(2).join(" ")
  f.parent nil
end
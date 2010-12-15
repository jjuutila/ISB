Factory.define :section do |f|
  f.name {Faker::Lorem.words(2).join(" ")}
  f.slug {Faker::Lorem.words(2).join("-").downcase}
  f.parent nil
end
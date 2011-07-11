Factory.define :section do |f|
  f.name {Faker::Lorem.words(2).join(" ")}
  f.slug {Faker::Lorem.words(2).join("-").downcase}
  f.group { Factory.build :section_group }
  f.picasa_user_id { Faker::Lorem.words(1) }
end
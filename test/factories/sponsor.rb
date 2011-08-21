FactoryGirl.define do
  sequence :sponsor_name do |n|
    "Sponsor #{n}"
  end
end

Factory.define :sponsor do |f|
  f.name { Factory.next(:sponsor_name) }
  f.url { "http://" << Faker::Internet.domain_name }
  f.logo_file_name { Faker::Lorem.words(2).join("_") << ".jpg" }
  f.logo_content_type "image/jpeg"
  f.logo_file_size { rand(20000) + 19870 }
  f.logo_width 190
  f.logo_height 120
  # position is auto generated
end

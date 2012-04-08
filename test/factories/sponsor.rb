FactoryGirl.define do
  sequence :sponsor_name do |n|
    "Sponsor #{n}"
  end

  factory :sponsor do
    name { FactoryGirl.generate(:sponsor_name) }
    url { "http://" << Faker::Internet.domain_name }
    logo_file_name { Faker::Lorem.words(2).join("_") << ".jpg" }
    logo_content_type "image/jpeg"
    logo_file_size { rand(20000) + 19870 }
    logo_width 190
    logo_height 120
    # position is auto generated in the model
  end
end

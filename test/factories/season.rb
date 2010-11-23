Factory.define :season do |f|
  f.sequence(:division ) {|n| "#{n}. divisioona" }
  f.history Faker::Lorem.paragraph(1)
  f.state "active"
  f.association :section
  f.start_year 2010
end
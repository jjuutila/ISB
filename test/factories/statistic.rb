FactoryGirl.define do
  factory :statistic do
    assists rand(100)
    goals rand(100)
    pim rand(100)
    matches rand(100)
  end
end

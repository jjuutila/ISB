FactoryGirl.define do
  factory :team_standing do
    sequence(:name) {|n| "Team #{n}" }
  end
end
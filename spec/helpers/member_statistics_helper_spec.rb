require 'spec_helper'

RSpec::Matchers.define :have_same_stats do |expected|
  match do |actual|
    actual.matches == expected.matches and
      actual.pim == expected.pim and
      actual.assists == expected.assists and
      actual.goals == expected.goals
  end
  
  diffable
end

describe MemberStatisticsHelper do
  describe 'sum_statistics_per_seasaon' do
    it 'sums points, assists, goals, matches and penalty minutes per season' do
      statistics = []

      season1 = FactoryGirl.build(:season)
      p1 = season1.partitions.build()
      p2 = season1.partitions.build()
      statistics.push p1.statistics.build({:goals => 2, :assists => 2, :matches => 2, :pim => 0})
      statistics.push p2.statistics.build({:goals => 4, :assists => 5, :matches => 7, :pim => 4})

      season2 = FactoryGirl.build(:season)
      p3 = season2.partitions.build()
      statistics.push p3.statistics.build({:goals => 4, :assists => 5, :matches => 7, :pim => 2})

      results = sum_statistics_per_season(statistics)
      results[season1].should have_same_stats Statistic.new({:goals => 6, :assists => 7, :matches => 9, :pim => 4})
      results[season2].should have_same_stats Statistic.new({:goals => 4, :assists => 5, :matches => 7, :pim => 2})
    end
  end
end

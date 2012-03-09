module MemberStatisticsHelper
  def sum_statistics_per_season statistics
    results = Hash.new

    statistics.each do |statistic|
      season = statistic.partition.season

      unless results.has_key? season
        results[season] = Statistic.new({:goals => 0, :assists => 0, :matches => 0, :pim => 0})
      end

      results[season] += statistic
    end

    results
  end
end

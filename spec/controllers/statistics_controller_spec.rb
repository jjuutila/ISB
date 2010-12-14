require 'spec_helper'

describe Admin::StatisticsController do

  def mock_statistic(stubs={})
    (@mock_statistic ||= mock_model(Statistic).as_null_object).tap do |statistic|
      statistic.stub(stubs) unless stubs.empty?
    end
  end

end

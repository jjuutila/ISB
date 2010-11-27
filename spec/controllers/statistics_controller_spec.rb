require 'spec_helper'

describe Admin::StatisticsController do

  def mock_statistic(stubs={})
    (@mock_statistic ||= mock_model(Statistic).as_null_object).tap do |statistic|
      statistic.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all statistics as @statistics" do
      Statistic.stub(:all) { [mock_statistic] }
      get :index
      assigns(:statistics).should eq([mock_statistic])
    end
  end

  describe "GET edit" do
    it "assigns the requested statistic as @statistic" do
      Statistic.stub(:find).with("37") { mock_statistic }
      get :edit, :id => "37"
      assigns(:statistic).should be(mock_statistic)
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested statistic" do
        Statistic.should_receive(:find).with("37") { mock_statistic }
        mock_statistic.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :statistic => {'these' => 'params'}
      end

      it "assigns the requested statistic as @statistic" do
        Statistic.stub(:find) { mock_statistic(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:statistic).should be(mock_statistic)
      end

      it "redirects to the statistic" do
        Statistic.stub(:find) { mock_statistic(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(statistic_url(mock_statistic))
      end
    end

    describe "with invalid params" do
      it "assigns the statistic as @statistic" do
        Statistic.stub(:find) { mock_statistic(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:statistic).should be(mock_statistic)
      end

      it "re-renders the 'edit' template" do
        Statistic.stub(:find) { mock_statistic(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

end

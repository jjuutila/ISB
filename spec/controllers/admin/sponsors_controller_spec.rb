require 'spec_helper'

describe Admin::SponsorsController do
  user_login
  
  def mock_sponsor(stubs={})
    (@mock_sponsor ||= mock_model(Sponsor).as_null_object).tap do |sponsor|
      sponsor.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all sponsors as @sponsors" do
      Sponsor.should_receive(:all).with(no_args()) {[mock_sponsor]}
      get :index
      assigns(:sponsors).should eq([mock_sponsor])
    end
  end
  
  describe "PUT positions" do
    before(:each) do
      @params = {"these" => "params"}
    end
    
    describe "with valid params" do
      it "returns 200 OK" do
        Sponsor.should_receive(:set_positions).with(@params)
        xhr :put, :positions, {:positions => @params, :format => 'js'}
        response.should be_success
      end
    end
    
    describe "with invalid params" do
      it "returns 500" do
        Sponsor.should_receive(:set_positions).and_raise(ArgumentError)
        xhr :put, :positions, {:positions => @params, :format => 'js'}
        response.status.should == 500
      end
    end
    
    describe "with any error" do
      it "returns 500" do
        Sponsor.should_receive(:set_positions).and_raise(Exception)
        xhr :put, :positions, {:positions => @params, :format => 'js'}
        response.status.should == 500
      end
    end
  end
end

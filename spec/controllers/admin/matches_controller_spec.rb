require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe Admin::MatchesController do

  def mock_match(stubs={})
    @mock_match ||= mock_model(Match, stubs).as_null_object
  end
  
  before(:each) do
    @season = mock_model(Season)
    Season.stub(:find).with(@season.id) { @season }
    
    @partition = mock_model(Partition)
    Partition.stub(:find).with(@partition.id) { @partition }
  end

  describe "GET index" do
    it "assigns all in partition's matches as @matches" do
      Match.stub(:where).with(:partition_id => @partition.id) { [mock_match] }
      get :index, :season_id => @season.id, :partition_id => @partition.id
      assigns(:matches).should eq([mock_match])
    end
  end

  describe "GET new" do
    it "assigns a new match as @match" do
      Match.stub(:new) { mock_match }
      get :new, :season_id => @season.id, :partition_id => @partition.id
      assigns(:match).should be(mock_match)
    end
  end

  describe "GET edit" do
    it "assigns the requested match as @match" do
      Match.stub(:find).with("37") { mock_match }
      get :edit, :id => "37", :season_id => @season.id, :partition_id => @partition.id
      assigns(:match).should be(mock_match)
    end
  end

  describe "POST create" do
    describe "with valid params" do

      it "redirects to matches" do
        Match.stub(:new) { mock_match(:save => true) }
        post :create, :season_id => @season.id, :partition_id => @partition.id, :match => {}
        response.should redirect_to(admin_season_partition_matches_url(@season, @partition))
      end
      
      it "shows a flash message" do
        Match.stub(:new) { mock_match(:save => true) }
        post :create, :season_id => @season.id, :partition_id => @partition.id, :match => {}
        flash[:notice].should == 'Uusi ottelu luotu.'
      end      
      
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved match as @match" do
        Match.stub(:new).with({'these' => 'params', 'partition' => @partition}) { mock_match(:save => false) }
        post :create, :season_id => @season.id, :partition_id => @partition.id, :match => {'these' => 'params'}
        assigns(:match).should be(mock_match)
      end

      it "re-renders the 'new' template" do
        Match.stub(:new) { mock_match(:save => false) }
        post :create, :season_id => @season.id, :partition_id => @partition.id, :match => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested match" do
        Match.stub(:find).with("37") { mock_match }
        mock_match.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :season_id => @season.id, :partition_id => @partition.id, :id => "37", :match => {'these' => 'params'}
      end

      it "assigns the requested match as @match" do
        Match.stub(:find) { mock_match(:update_attributes => true) }
        put :update, :season_id => @season.id, :partition_id => @partition.id, :id => "1"
        assigns(:match).should be(mock_match)
      end

      it "redirects to matches" do
        Match.stub(:find) { mock_match(:update_attributes => true) }
        put :update, :season_id => @season.id, :partition_id => @partition.id, :id => "1"
        response.should redirect_to(admin_season_partition_matches_url(@season, @partition))
      end
    end

    describe "with invalid params" do
      it "assigns the match as @match" do
        Match.stub(:find) { mock_match(:update_attributes => false) }
        put :update, :season_id => @season.id, :partition_id => @partition.id, :id => "1"
        assigns(:match).should be(mock_match)
      end

      it "re-renders the 'edit' template" do
        Match.stub(:find) { mock_match(:update_attributes => false) }
        put :update, :season_id => @season.id, :partition_id => @partition.id, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested match" do
      Match.stub(:find).with("37") { mock_match }
      mock_match.should_receive(:destroy)
      delete :destroy, :season_id => @season.id, :partition_id => @partition.id, :id => "37"
    end

    it "redirects to the matches list" do
      Match.stub(:find) { mock_match }
      delete :destroy, :season_id => @season.id, :partition_id => @partition.id, :id => "1"
      response.should redirect_to(admin_season_partition_matches_url(@season, @partition))
    end
  end

end

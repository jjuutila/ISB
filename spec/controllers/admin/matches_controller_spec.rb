# coding: utf-8
require 'spec_helper'

describe Admin::MatchesController do

  def mock_match(stubs={})
    @mock_match ||= mock_model(Match, stubs).as_null_object
  end
  
  before(:each) do
    @partition = mock_model(Partition)
    Partition.stub(:find).with(@partition.id) { @partition }
    @params = {'these' => 'params'}
  end

  describe "GET index" do
    it "assigns all in partition's matches as @matches" do
      Match.stub(:where).with(:partition_id => @partition.id) { [mock_match] }
      get :index, :partition_id => @partition.id
      assigns(:matches).should eq([mock_match])
    end
  end

  describe "GET new" do
    it "assigns a new match as @match" do
      Match.stub(:new) { mock_match }
      get :new, :partition_id => @partition.id
      assigns(:match).should be(mock_match)
    end
  end

  describe "GET edit" do
    it "assigns the requested match as @match" do
      Match.stub(:find).with("37") { mock_match }
      get :edit, :id => "37", :partition_id => @partition.id
      assigns(:match).should be(mock_match)
    end
  end

  describe "POST create" do
    describe "with valid params" do

      it "redirects to matches" do        
        @partition.stub_chain(:matches, :build).with(@params).and_return(mock_match(:save => true))
        post :create, :partition_id => @partition.id, :match => @params
        response.should redirect_to admin_partition_matches_url(@partition)
      end
      
      it "shows a flash message" do
        @partition.stub_chain(:matches, :build).with(@params).and_return(mock_match)
        post :create, :partition_id => @partition.id, :match => @params
        flash[:notice].should == 'Uusi ottelu luotu.'
      end      
      
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved match as @match" do
        @partition.stub_chain(:matches, :build).and_return(mock_match(:save => false))
        post :create, :partition_id => @partition.id, :match => @params
        assigns(:match).should be(mock_match)
      end

      it "re-renders the 'new' template" do
        @partition.stub_chain(:matches, :build).and_return(mock_match(:save => false))
        post :create, :partition_id => @partition.id, :match => @params
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested match" do
        Match.stub(:find).with("37") { mock_match }
        mock_match.should_receive(:update_attributes).with(@params)
        put :update, :partition_id => @partition.id, :id => "37", :match => @params
      end

      it "assigns the requested match as @match" do
        Match.stub(:find) { mock_match(:update_attributes => true) }
        put :update, :partition_id => @partition.id, :id => "1"
        assigns(:match).should be(mock_match)
      end

      it "redirects to matches" do
        Match.stub(:find) { mock_match(:update_attributes => true) }
        put :update, :partition_id => @partition.id, :id => "1"
        response.should redirect_to(admin_partition_matches_url(@partition))
      end
      
      it "shows a flash message" do
        Match.stub(:find) { mock_match(:update_attributes => true) }
        put :update, :partition_id => @partition.id, :id => "1"
        flash[:notice].should include('päivitetty')
      end  
    end

    describe "with invalid params" do
      it "assigns the match as @match" do
        Match.stub(:find) { mock_match(:update_attributes => false) }
        put :update, :partition_id => @partition.id, :id => "1"
        assigns(:match).should be(mock_match)
      end

      it "re-renders the 'edit' template" do
        Match.stub(:find) { mock_match(:update_attributes => false) }
        put :update, :partition_id => @partition.id, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested match" do
      Match.stub(:find).with("37") { mock_match }
      mock_match.should_receive(:destroy)
      delete :destroy, :partition_id => @partition.id, :id => "37"
    end

    it "redirects to the matches list" do
      Match.stub(:find) { mock_match }
      delete :destroy, :partition_id => @partition.id, :id => "1"
      response.should redirect_to(admin_partition_matches_url(@partition))
    end
  end

end

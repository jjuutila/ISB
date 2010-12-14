require 'spec_helper'

describe Admin::PartitionsController do

  def mock_partition(stubs={})
    (@mock_partition ||= mock_model(Partition).as_null_object).tap do |partition|
      partition.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET show" do
    it "assigns the requested partition as @partition" do
      Partition.stub(:find).with("37", :include => [:season]) { mock_partition }
      get :show, :id => "37", :season_id => '2'
      assigns(:partition).should be(mock_partition)
    end
  end

  describe "GET new" do
    it "assigns a new partition as @partition" do
      Partition.stub(:new).with(:season_id => '2') { mock_partition }
      get :new, :season_id => '2'
      assigns(:partition).should be(mock_partition)
    end
  end

  describe "GET edit" do
    it "assigns the requested partition as @partition" do
      Partition.stub(:find).with("37") { mock_partition }
      get :edit, :id => "37", :season_id => '2'
      assigns(:partition).should be(mock_partition)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created partition as @partition" do
        Partition.stub(:new).with({'these' => 'params'}) { mock_partition(:save => true) }
        post :create, :season_id => '2', :partition => {'these' => 'params'}
        assigns(:partition).should be(mock_partition)
      end

      it "redirects to the created partition" do
        season = mock_model(Season)
        Partition.stub(:new) { mock_partition(:save => true, :season => season) }        
        post :create, :season_id => season.id, :partition => {}
        response.should redirect_to(admin_season_partition_path(season, mock_partition))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved partition as @partition" do
        Partition.stub(:new).with({'these' => 'params'}) { mock_partition(:save => false) }
        post :create, :season_id => '2', :partition => {'these' => 'params'}
        assigns(:partition).should be(mock_partition)
      end

      it "re-renders the 'new' template" do
        Partition.stub(:new) { mock_partition(:save => false) }
        post :create, :season_id => '2', :partition => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested partition" do
        Partition.should_receive(:find).with("37") { mock_partition }
        mock_partition.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :season_id => '2', :id => "37", :partition => {'these' => 'params'}
      end

      it "assigns the requested partition as @partition" do
        Partition.stub(:find) { mock_partition(:update_attributes => true) }
        put :update, :season_id => '2', :id => "1"
        assigns(:partition).should be(mock_partition)
      end

      it "redirects to the partition" do
        season = mock_model(Season)
        Partition.stub(:find) { mock_partition(:update_attributes => true, :season => season) }
        put :update, :season_id => '2', :id => "1"
        response.should redirect_to(admin_season_partition_path(season, mock_partition))
      end
    end

    describe "with invalid params" do
      it "assigns the partition as @partition" do
        Partition.stub(:find) { mock_partition(:update_attributes => false) }
        put :update, :season_id => '2', :id => "1"
        assigns(:partition).should be(mock_partition)
      end

      it "re-renders the 'edit' template" do
        Partition.stub(:find) { mock_partition(:update_attributes => false) }
        put :update, :season_id => '2', :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested partition" do
      Partition.should_receive(:find).with("37") { mock_partition }
      mock_partition.should_receive(:destroy)
      delete :destroy, :season_id => '2', :id => "37"
    end

    it "redirects to the partitions list" do
      Partition.stub(:find) { mock_partition }
      delete :destroy, :season_id => '2', :id => "1"
      response.should redirect_to(admin_seasons_path)
    end
  end

end
require 'spec_helper'

describe Admin::MembersController do
  user_login
  
  def mock_member(stubs={})
    @mock_member ||= mock_model(Member, stubs).as_null_object
  end
  
  describe "GET 'index'" do
    it "should assign all members as @members" do
      Member.should_receive(:all).and_return([mock_member])
      get 'index'
      assigns(:members).should == [mock_member]
    end
  end
  
  describe "GET 'new'" do
    it "should assign a new record as @member" do
      get 'new'
      assigns(:member).new_record?.should == true
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @attributes = {"these" => "params"}
    end
    
    describe "with valid parameters" do
      it "should create a new member" do
        Member.stub(:new).with(@attributes) { mock_member }
        mock_member.should_receive(:save)
        post :create, :member => @attributes
      end
      
      it "should redirect to index" do
        Member.stub(:new) { mock_member(:save => true) }
        post :create, :member => @attributes
        response.should redirect_to admin_members_path
      end
    end
    
    describe "with invalid params" do
      it "shows the create view" do
        Member.stub(:new) { mock_member(:save => false, :errors => {:some => :errors}) }
        post :create, :member => @attributes
        response.should render_template "new"
      end
      
      it "sets the member as @member" do
        Member.stub(:new) { mock_member }
        post :create, :member => @attributes
        assigns(:member).should == mock_member
      end
    end
  end
  
  describe "GET 'edit'" do    
    it "sets the requested member as @member" do
      Member.should_receive(:find).with(5) { mock_member }
      get 'edit', :id => 5
      assigns(:member).should == mock_member
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @attributes = {:first_name => "John", :last_name => "Smith", :gender => true,
        :birth_year => 1984, :number => 2}
    end
    
    describe "with valid parameters" do
      it "should redirect to members page" do
        Member.stub(:find) { mock_member(:update_attributes => true) }
        put 'update', :id => 4
        response.should redirect_to admin_members_path
      end
    end
    
    describe "with invalid parameters" do
      it "should render edit page if errors in member." do
        Member.stub(:find) { mock_member(:update_attributes => false, :errors => {:some => :errors}) }
        put :update, {:member => @attributes, :id => 5 }
        response.should render_template("edit")
      end
      
      it "assigns the member as @member" do
        Member.should_receive(:find).with(5) { mock_member(:update_attributes => false) }
        put :update, {:member => @attributes, :id => 5 }
        assigns(:member).should == mock_member
      end
    end
  end
end

require 'spec_helper'

describe Admin::MembersController do
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      assigns(:member).new_record?.should == true
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      member = Factory.build(:member)
      @attributes = {:first_name => "John", :last_name => "Smith", :gender => true,
        :birth_year => 1984, :number => 4}  
    end
    
    it "should redirect to index page after successfull create." do
      post :create, :member => @attributes
      #assigns(:publication).user.id.should == @admin.id
      assigns(:member).errors.size.should == 0
      assigns(:member).new_record?.should == false
      response.should redirect_to admin_members_path
    end
  end
  
  describe "GET 'edit'" do    
    before(:each) do
      @member = Factory(:member)  
    end
        
    it "should be successful" do
      get 'edit', :id => @member.id.to_s 
      assigns(:member).id.should == @member.id
      response.should be_success
    end
  end
end
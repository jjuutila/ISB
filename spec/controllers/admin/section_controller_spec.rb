require 'spec_helper'

describe Admin::SectionsController do
  
  def mock_section(stubs={})
    (@mock_section ||= mock_model(Section).as_null_object).tap do |section|
      section.stub(stubs) unless stubs.empty?
    end
  end
  
  describe "GET 'edit_contact'" do
    describe "with leaf section" do
      it "assigns the requested section as @section" do
        Section.should_receive(:find).with(2) { mock_section(:parent => mock_model(Section)) }
        get 'edit_contact', :id => 2
        assigns(:section).should == mock_section
        response.should be_success
      end
    end
    
    describe "with parent section" do
      before(:each) do
        Section.stub(:find) { mock_section(:parent => nil) }
      end
      
      it "redirects to index" do
        get 'edit_contact', :id => 2
        response.should redirect_to admin_sections_path
      end
      
      it "sets flash.error message" do
        get 'edit_contact', :id => 2
        flash[:alert].should == 'Vain joukkueosioiden historiatietoja voi muokata.'
      end
    end
  end
  
  describe "PUT 'update_contact'" do
    describe "with valid params" do
      it "redirects to sections" do
        Section.stub(:find) { mock_section(:update_attributes => true) }
        post :update_contact, :id => 2, :section => {:history => 'foo'}
        response.should redirect_to admin_sections_path
      end
      
      it "sets the flash.notice message" do
        Section.stub(:find) { mock_section(:update_attributes => true) }
        post :update_contact, :id => 2, :section => {:history => 'foo'}
        flash[:notice].should == 'Yhteystiedot päivitetty.'
      end
    end
    
    describe "with invalid params" do
      it "assigns requested section as @section" do
        Section.stub(:find) { mock_section(:update_attributes => false, :errors => {:any => "error"}) }
        put :update_contact, :id => 1
        assigns(:section).should == mock_section
      end
      
      it "re-renders the 'edit_contact' template" do
        Section.stub(:find) { mock_section(:update_attributes => false, :errors => {:any => "error"}) }
        put :update_contact, :id => 1
        response.should render_template("edit_contact")
      end
    end
  end
end
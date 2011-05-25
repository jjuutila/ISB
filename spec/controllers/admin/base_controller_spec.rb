# coding: utf-8
require 'spec_helper'

describe Admin::BaseController do
  user_login
  
  describe "selected_section" do
    before(:each) do
      user = mock_model(User)
      @section = mock_model(Section)
      user.should_receive(:selected_section) { @section }
      controller.stub(:current_admin_user) { user }
    end
    it "returns current user's section" do
      controller.selected_section.should == @section
    end
    
    it "sets current user's section as @selected_section" do
      controller.selected_section
      assigns(:selected_section).should == @section
    end
  end
  
  describe "PUT 'change_section'" do
    before(:each) do
      @user = mock_model(User)
      controller.stub(:current_admin_user) { @user }
      @section = mock_model(Section)
      @request.env["HTTP_REFERER"] = admin_news_index_path
    end
    
    describe "with valid params" do
      it "updates User.section with requrested section" do
        Section.should_receive(:find_by_slug).with("section_slug") { @section }
        @user.should_receive(:selected_section=).with(@section)
        @user.should_receive(:save!).with() { true }
        put :change_section, :section => 'section_slug'
      end
      
      it "redirects to HTTP referer" do
        Section.stub(:find_by_slug) { @section }
        @user.stub(:selected_section=).with(@section)
        @user.stub(:save!).with() { true }
        put :change_section, :section => 'section_slug'
        response.should redirect_to admin_news_index_path
      end
    end
    
    describe "sets the flash.alert" do
      before(:each) do
        @user.stub(:selected_section=).with(@section)
        @user.stub(:save!).with().and_raise(ActiveRecord::RecordInvalid)
      end
      
      it "when user is invalid" do
        # Also a Section that isn't a leaf invalidates user
        Section.stub(:find_by_slug) { @section }
        put :change_section, :section => 'section_slug'
        flash.alert.should == "Virheellinen joukkueosio. Mitään ei muutettu."
      end
      
      it "section is not found with specified slug" do
        Section.should_receive(:find_by_slug).with("non_existing_section_slug").and_raise(ActiveRecord::RecordNotFound)
        put :change_section, :section => 'non_existing_section_slug'
        flash.alert.should == "Virheellinen joukkueosio. Mitään ei muutettu."
      end
    end
  end
end

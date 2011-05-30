# coding: utf-8

require 'spec_helper'

describe Admin::ConfirmationsController do
  def mock_user(stubs={})
    (@mock_user ||= mock_model(User).as_null_object).tap do |user|
      user.stub(stubs) unless stubs.empty?
    end
  end
  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @token = 'abcdef'
  end
    
  describe "GET 'show'" do
    before(:each) do
      @params = { :confirmation_token => @token }
      User.stub(:find_by_confirmation_token!).with(@token) { mock_user }
    end

    it "assigns requested user as @user" do
      get :show, @params
      assigns(:user).should eq(mock_user)
    end
  end
  
  describe "PUT 'confirm'" do
    before(:each) do
      @params = { :confirmation_token => @token, :user => {:these => :params } }
      User.stub(:find_by_confirmation_token!).with(@token) { mock_user }
      controller.stub(:sign_in)
      mock_user.stub(:confirm!)
    end
    
    describe "with valid params" do
      before(:each) do
        mock_user.stub(:update_attributes) { true }
      end
      
      it "assigns requested user as @user" do
        put :confirm, @params
        assigns(:user).should eq(mock_user)
      end
      
      it "updates users password" do
        mock_user.should_receive(:update_attributes).with('these' => :params) { true }
        put :confirm, @params
      end
      
      it "sets flash.notice" do
        put :confirm, @params
        flash.notice.should == 'Tervetuloa ISB:n hallintasivujen käyttäjäksi.'
      end
      
      it "confirms the requested user" do
        mock_user.should_receive(:confirm!).with(no_args())
        put :confirm, @params
      end
      
      it "signs user in" do
        controller.should_receive(:sign_in).with(mock_user)
        put :confirm, @params
      end
      
      it "redirects to news" do
        post :confirm, @params
        response.should redirect_to admin_news_index_path
      end
    end
    
    describe "with invalid params" do
      before(:each) do
        mock_user.stub(:update_attributes) { false }
        mock_user.stub(:errors).and_return({ :any => :error })
      end
      
      it "re-renders the 'show' template" do
        put :confirm, @params
        response.should render_template('show')
      end
      
      it "doesn't confirm user" do
        mock_user.should_receive(:confirm!).exactly(0).times
        put :confirm, @params
      end
    end
  end
end

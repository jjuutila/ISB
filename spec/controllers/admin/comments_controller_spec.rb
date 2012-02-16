# coding: utf-8
require 'spec_helper'

describe Admin::CommentsController do
  user_login
  
  def mock_comment(stubs={})
    (@mock_comment ||= mock_model(Comment).as_null_object).tap do |comment|
      comment.stub(stubs) unless stubs.empty?
    end
  end
  
  describe "GET index" do
    it "assigns all in selected section's comments as @comments" do
      mock_section = mock_model(Section)
      controller.stub(:selected_section) { mock_section }
      Comment.should_receive(:messages).with(mock_section, nil) { [mock_comment] }
      
      get :index
      
      assigns(:comments).should eq([mock_comment])
    end
  end

  describe "PUT update" do
    before(:each) do
      Comment.stub(:find).with("37") { mock_comment }
    end
    describe "with valid params" do
      it "updates the requested comment" do
        mock_comment.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => 37, :comment => {'these' => 'params'}
      end

      it "assigns the requested comment as @comment" do
        put :update, :id => 37
        assigns(:comment).should be(mock_comment)
      end

      it "redirects to the comments page" do
        mock_comment.stub(:update_attributes).and_return(true)
        put :update, :id => 37
        response.should redirect_to admin_comments_path
      end
      
      it "sets the flash.notice" do
        mock_comment.stub(:update_attributes).and_return(true)
        put :update, :id => 37
        flash[:notice].should == 'Viesti päivitetty.'
      end
    end

    describe "with invalid params" do
      it "assigns the comment as @comment" do
        put :update, :id => 37
        assigns(:comment).should be(mock_comment)
      end

      it "re-renders the 'edit' template" do
        mock_comment.should_receive(:update_attributes).with({'these' => 'params'}).and_return(false)
        mock_comment.stub(:errors).and_return(:any => :errors)
        put :update, :id => 37, :comment => {'these' => 'params'}
        response.should render_template("edit")
      end
    end
  end
  
  describe "DELETE destroy" do
    it "destroys the requested comment" do
      Comment.stub(:find).with("37") { mock_comment }
      mock_comment.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the comment list" do
      Comment.stub(:find) { mock_comment }
      delete :destroy, :id => "1"
      response.should redirect_to admin_comments_path
    end
    
    it "redirects to the comment list" do
      Comment.stub(:find) { mock_comment }
      delete :destroy, :id => "1"
      flash[:notice].should == 'Viesti poistettu.'
    end
  end
end
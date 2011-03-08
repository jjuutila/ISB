# coding: utf-8
require 'spec_helper'

describe SectionController do
  def mock_section(stubs={})
    (@mock_section ||= mock_model(Section).as_null_object).tap do |section|
      section.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_news(stubs={})
    (@mock_news ||= mock_model(News).as_null_object).tap do |news|
      news.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_partition(stubs={})
    (@mock_partition ||= mock_model(Partition).as_null_object).tap do |partition|
      partition.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_comment(stubs={})
    (@mock_comment ||= mock_model(Comment).as_null_object).tap do |comment|
      comment.stub(stubs) unless stubs.empty?
    end
  end
  
  before(:each) do
    Section.should_receive(:find_by_slug).and_return(mock_section(:slug => "edustus"))
  end
  
  describe "'GET' news" do
    it "sets requested news posts as @news" do
      News.should_receive(:in_section).with(mock_section) {[mock_news]}
      get :news, :section => 'edustus'
      assigns(:news).should == [mock_news]
    end
  end
  
  describe "'GET' matches" do
    it "sets the latest partition in requested section as @partition" do
      Partition.should_receive(:latest).with(mock_section).and_return(mock_partition)
      
      mock_match = mock_model(Match)
      Match.stub(:where) {[mock_match]}
      
      get :matches, :section => 'edustus'
      assigns(:partition).should == mock_partition
    end
    
    it "sets matches from the newest partition in requested section as @matches" do
      Partition.stub(:latest) {mock_partition}
      
      mock_match = mock_model(Match)
      Match.should_receive(:where).with(:partition_id => mock_partition.id).and_return([mock_match])
      
      get :matches, :section => 'edustus'
      assigns(:matches).should == [mock_match]
    end
  end
  
  describe "'GET' show_match" do
    it "sets the requested match as @match" do
      mock_match = mock_model(Match)
      Match.should_receive(:find).with(3).and_return(mock_match)
      get :show_match, :section => 'edustus', :id => 3
      assigns(:match).should == mock_match
    end
  end
  
  describe "'GET' guestbook" do
    it "sets the requested sections comments as @messages" do
      Comment.should_receive(:messages).with(mock_section, 2).and_return([mock_comment])
      get :guestbook, :section => 'edustus', :page => 2
      assigns(:messages).should == [mock_comment]
    end
  end
  
  describe "'GET' new_guestbook_message" do
    it "assigns a new comment as @message" do
      Comment.should_receive(:new).and_return(mock_comment)
      get :new_guestbook_message, :section => 'edustus'
      assigns(:message).should == mock_comment
    end
  end
  
  describe "'POST' create_guestbook_message" do
    before(:each) do
      @params = {'these' => 'params'}
    end
    
    describe "with valid params" do
      it "assigns a newly created comment as @message" do
        mock_section.stub_chain(:comments, :build).with(@params) { mock_comment(:save => true) }
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        assigns(:message).should == mock_comment
      end
      
      it "redirects to guestbook page" do
        mock_section.stub_chain(:comments, :build).with(@params) { mock_comment(:save => true) }
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        response.should redirect_to(guestbook_path(mock_section.slug))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @message" do
        mock_section.stub_chain(:comments, :build).with(@params) { mock_comment(:save => false,
          :errors => {"some" => "error"}) }
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        assigns(:message).should == mock_comment
      end
      
      it "re-renders the new_guestbook_message page" do
        mock_section.stub_chain(:comments, :build).with(@params) { mock_comment(:save => false,
          :errors => {"some" => "error"}) }
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        should_not respond_with(:redirect)
        response.should render_template("new_guestbook_message")
      end
    end
  end
end
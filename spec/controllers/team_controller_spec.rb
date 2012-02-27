# coding: utf-8
require 'spec_helper'

describe TeamController do
  def member_mock(stubs={})
    (@mock_member ||= mock_model(Member).as_null_object).tap do |member|
      member.stub(stubs) unless stubs.empty?
    end
  end

  let(:season_mock) { mock_model(Season) }

  create_section

  describe "'GET' player" do
    it "assigns requested member as @member" do
      mock_player = mock_model(Member)
      Member.should_receive(:find).with("3").and_return(mock_player)
      get :show, :section => 'edustus', :id => 3
      assigns(:member).should == mock_player
    end
  end

  describe "'GET' team" do
    it "assigns requested section's most recent's season's players as @players" do
      Season.stub(:latest) {season_mock}
      Member.stub(:with_role_in_season).with("player", season_mock).and_return([member_mock])
      get :index, :section => 'edustus'
      assigns(:players).should == [member_mock]
    end
    
    it "assigns @players, @assistants and @coaches as an empty array if season is not found" do
      Season.should_receive(:latest).and_raise(ActiveRecord::RecordNotFound)
      get :index, :section => 'edustus'
      assigns(:coaches).should == []
      assigns(:players).should == []
      assigns(:assistants).should == []
    end
  end
end

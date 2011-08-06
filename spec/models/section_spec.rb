# coding: utf-8
require 'spec_helper'

describe Section do
  def valid_attributes
    { :name => 'A Section', :slug => 'a-section', :group => mock_model(SectionGroup) }
  end
  
  context "validations" do
    it { should belong_to(:group) }
    it { should validate_presence_of(:group) }
    
    it { should have_and_belong_to_many(:news) }
    it { should have_many(:link_categories) }
    it { should have_many(:seasons) }
    it { should have_many(:comments) }
      
    it { should validate_presence_of(:name) }
    it { should_not allow_value("").for(:name) }
    
    it { should validate_presence_of(:slug) }
    it "should only accept unique slugs" do
      Section.create!(valid_attributes)
      Section.new.should validate_uniqueness_of(:slug)
    end
    
    it { subject.respond_to?(:picasa_user_id).should be true }
  end
end

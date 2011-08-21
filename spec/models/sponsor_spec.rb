require 'spec_helper'

describe Sponsor do
  it { should validate_presence_of(:name) }
  
  it { should validate_numericality_of(:position) }
  
  it { should validate_format_of(:url).
          with('http://www.address.net').
          with_message(/osoite/) }
          
  it "accepts an empty url" do
    sponsor = Sponsor.create :url => ''
    sponsor.should have(0).error_on(:url)
  end
  
  it { should have_attached_file(:logo) }
  it { should validate_attachment_presence(:logo) }
  it { should validate_attachment_content_type(:logo).
          allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg').
          rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:logo).
          less_than(2.megabytes) }
  
  describe "before validation" do
    it "sets the largest position if position is nil" do
      FactoryGirl.create :sponsor, :name => 'Last Sponsor', :position => 5
      
      new_sponsor = FactoryGirl.create :sponsor
      new_sponsor.position.should == 6
    end
    
    it "sets position as 1 if no sponsors exists" do
      new_sponsor = FactoryGirl.create :sponsor
      new_sponsor.position.should == 1
    end
  end
  
  describe "set_positions" do
    it { respond_to(:set_positions) }
    
    describe "with valid argument" do
      before(:each) do        
        @created_sponsors = FactoryGirl.create_list(:sponsor, 3)
        @sponsor_ids_in_order = [@created_sponsors[2].id, @created_sponsors[0].id, @created_sponsors[1].id]
      end
      
      it "sets new positions for sponsors" do
        Sponsor.set_positions @sponsor_ids_in_order
        check_sponsor_positions
      end
      
      it "skips ID if a sponsor is not found" do
        non_existing_id = @created_sponsors[2].id + 1
        @sponsor_ids_in_order << non_existing_id
        
        lambda { Sponsor.set_positions @sponsor_ids_in_order }.should_not raise_error
      end
      
      it "sorts also with string IDs" do
        sponsor_ids_as_strings = @sponsor_ids_in_order.collect {|id| id.to_s}
        Sponsor.set_positions sponsor_ids_as_strings
        check_sponsor_positions
      end
      
      def check_sponsor_positions
        sponsors_after_positioning = Sponsor.all
        sponsors_after_positioning[0].should == @created_sponsors[2]
        sponsors_after_positioning[1].should == @created_sponsors[0]
        sponsors_after_positioning[2].should == @created_sponsors[1]
      end
    end
    
    describe "with invalid argument" do
      it "raises an ArgumentError" do
        not_an_array = "1, 2, 3"
        lambda {Sponsor.set_positions(not_an_array)}.should raise_error(ArgumentError)
      end
    end
  end
  
  describe "logo_dimensions" do
    it "returns logo dimensions in format width x height" do
      sponsor = Sponsor.new :logo_width => 190, :logo_height => 115
      sponsor.logo_dimensions.should == '190x115'
    end
  end
end

require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] ||= 'test'

module ControllerMacros
  def user_login
    before(:each) do
      @user = Factory.build(:user)
      @user.confirm!
      @user.save!
      sign_in @user
    end
  end
  
  # For main site's before_filter
  def find_section
    before(:each) do
      @section = mock_model(Section).as_null_object
      @section.stub(:slug) { "edustus" }
      Section.stub(:find_leaf_by_slug).with('edustus').and_return(@section)
    end
  end
end

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'shoulda'
  
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  
  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec
  
    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    #config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
    
    # Device helpers
    config.include Devise::TestHelpers, :type => :controller
    config.extend ControllerMacros, :type => :controller
  end
  
end

Spork.each_run do
  # This code will be run each time you run your specs.
  
end

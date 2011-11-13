require 'spec_helper'

describe PicasaController do
  def mock_user(stubs={})
    (@mock_user ||= mock(RubyPicasa::User).as_null_object).tap do |user|
      user.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_album(stubs={})
    (@mock_album ||= mock(RubyPicasa::Album).as_null_object).tap do |album|
      album.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_photo(stubs={})
    (@mock_photo ||= mock(RubyPicasa::Photo).as_null_object).tap do |photo|
      photo.stub(stubs) unless stubs.empty?
    end
  end
  
  create_section
  
  before(:each) do
    @picasa = mock(Picasa)
    Picasa.stub(:new).with(nil) { @picasa }
    @picasa.stub(:user).with('user_id').and_return(mock_user)
  end
  
  describe "GET 'index'" do
    it "assigns specified user's albums as @albums" do
      mock_user.stub(:albums) { [mock_album] }
      get :index, :section => 'edustus'
      assigns(:albums).should == [mock_album]
    end
    
    it "renders 'picasa_user_not_found' if user is not set or not found" do
      @picasa.stub(:user) { nil }
      get :index, :section => 'edustus'
      response.should render_template("picasa_user_not_found")
    end
  end
  
  describe "GET 'show_album'" do
    it "assigns requested album as @album" do
      mock_user.should_receive(:find_album_by_name).with('album_name') { mock_album }
      get :show_album, :section => 'edustus', :id => 'album_name'
      assigns(:album).should == mock_album
    end
  end
  
  describe "GET 'show_photo'" do
    it "assigns requested album as @album" do
      mock_user.should_receive(:find_album_by_name).with('album_name') { mock_album }
      get :show_photo, :section => 'edustus', :album_id => 'album_name', :id => 'photo_id'
      assigns(:album).should == mock_album
    end
    
    it "assigns requested photo as @photo" do
      mock_user.should_receive(:find_album_by_name).with('album_name') { mock_album }
      mock_album.should_receive(:find_photo).with('id') { mock_photo }
      get :show_photo, :section => 'edustus', :album_id => 'album_name', :id => 'id'
      assigns(:photo).should == mock_photo
    end
  end
end

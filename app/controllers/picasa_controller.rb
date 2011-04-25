# coding: utf-8

# Extensions for RubyPicasa::User and RubyPicasa::Album
require 'ruby_picasa_extensions'

class PicasaController < MainSiteController
  respond_to :html
  before_filter :get_picasa_user
  
  def index
    respond_with @albums = @user.albums
  end
  
  def show_album
    @album = @user.find_album_by_name(params[:id])
    respond_with @album
  end
  
  def show_photo
    @album = @user.find_album_by_name(params[:album_id])
    @album.extend RubyPicasaAlbumExtension
    @photo = @album.find_photo(params[:id])
    respond_with @photo
  end
  
  protected
  
  def get_picasa_user
    @picasa = Picasa.new nil
    @user = @picasa.user @section.picasa_user_id
    if @user
      @user.extend RubyPicasaUserExtension
    else
      render 'picasa_user_not_found'
    end
  end
end

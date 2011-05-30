# coding: utf-8
class Admin::BaseController < ActionController::Base
  before_filter :set_locale, :authenticate_user!
  protect_from_forgery
  layout 'admin/application'
  
  def set_locale
    I18n.locale = :fi
  end
  
  def selected_section
    @selected_section = current_user.selected_section
  end
  helper_method :selected_section
  
  def change_section
    begin
      current_user.selected_section = Section.find_by_slug(params[:section])
      current_user.save!
    rescue
      flash.alert = "Virheellinen joukkueosio. Mitään ei muutettu."
    end
  	redirect_to :back
  end
  
  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    admin_news_index_path
  end
end

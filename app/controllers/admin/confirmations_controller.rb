# coding: utf-8

class Admin::ConfirmationsController <  Devise::ConfirmationsController
  
  # Overwrite show method to provide password
  # GET /admin/users/confirmation?confirmation_token=abcdef
  def show
    @user = User.find_by_confirmation_token!(params[:confirmation_token])
  end
  
  def confirm
    @user = User.find_by_confirmation_token!(params[:confirmation_token])
    if @user.update_attributes(params[:user])
      @user.confirm!
      sign_in(@user)
      flash.notice = 'Tervetuloa ISB:n hallintasivujen käyttäjäksi.'
      redirect_to admin_news_index_path
    else
      render 'show'
    end
  end
end

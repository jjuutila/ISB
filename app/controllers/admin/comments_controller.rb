# coding: utf-8
class Admin::CommentsController < Admin::BaseController
  respond_to :html
  
  def index
    @comments = Comment.messages selected_section, params[:sivu]
    respond_with @comments
  end

  def edit
    respond_with @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    flash[:notice] = 'Viesti päivitetty.' if @comment.update_attributes(params[:comment])
    respond_with @comment, :location => admin_comments_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = 'Viesti poistettu.'
    respond_with @comment, :location => admin_comments_url
  end
end

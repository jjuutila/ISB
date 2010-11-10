# coding: utf-8
class Admin::CommentsController < Admin::BaseController
  # GET /admin/comments
  # GET /admin/comments.xml
  def index
    @admin_comments = Comment.paginate :page => params[:page], :order => 'created_at DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_comments }
    end
  end

  # GET /admin/comments/1
  # GET /admin/comments/1.xml
  def show
    @admin_comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_comment }
    end
  end

  # GET /admin/comments/new
  # GET /admin/comments/new.xml
  def new
    @admin_comment = Comment.new(:commentable_id => selected_section.id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_comment }
    end
  end

  # GET /admin/comments/1/edit
  def edit
    @admin_comment = Comment.find(params[:id])
  end

  # POST /admin/comments
  # POST /admin/comments.xml
  def create
    @admin_comment = Comment.new(params[:comment])
    
    respond_to do |format|
      if @admin_comment.save
        format.html { redirect_to(admin_comments_path(), :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @admin_comment, :status => :created, :location => @admin_comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/comments/1
  # PUT /admin/comments/1.xml
  def update
    @admin_comment = Comment.find(params[:id])

    respond_to do |format|
      if @admin_comment.update_attributes(params[:comment])
        format.html { redirect_to(admin_comments_path(), :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/comments/1
  # DELETE /admin/comments/1.xml
  def destroy
    @admin_comment = Comment.find(params[:id])
    @admin_comment.destroy

    respond_to do |format|
      format.html { redirect_to(admin_comments_url) }
      format.xml  { head :ok }
    end
  end
end

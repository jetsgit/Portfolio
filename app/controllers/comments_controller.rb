class CommentsController < ApplicationController
  before_action :set_post 
  before_filter :load_commentable
  before_filter :authenticate_user!, except: [:index, :show]

  # before_filter :load_commentable 
  def new
   @comment = @commentable.comments.new 
  end
  def create
    # @comment = @commentable.comments.new(comment_params)
    # if @comment.save
    #   redirect_to @commentable, notice: "Comment is awaiting moderation"
    # else
    #   instance__varaible_set("@#{@resource.singularize}")
    set_post
    @comment = @post.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def  index
    @comments = @commentable.comments
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment[ "author" ], :comment[ "author_email" ], :comment[ "comment" ], :post_id)
    end
    def  load_commentable
      resource, id = request.path.split('/')[1,2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end
end

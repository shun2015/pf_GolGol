class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.save
    unless @post.user == @post_comment.user
      @post.create_notification_comment(current_user, @post.user)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

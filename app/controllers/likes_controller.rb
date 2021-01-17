class LikesController < ApplicationController
    before_action :comment_or_post
    def create
        if @comment_like
            like_resource(comment)
        else
            like_resource(post)
        end
      end

      private

      def like_resource(obj)
        if obj.likes.where(user: current_user.id).present?
          flash[:notice] = "You've already liked this!"
        elsif obj.likes.create(user_id: current_user.id, likeable_id: obj.id, likeable_type: (comment) ? "Comment" : "Post")
          flash[:notice] = "Wooh, You Liked this!"
        else
          flash[:notice] = "An error prevented you from liking."
        end
        redirect_to post_path(post)
      end

      def comment_or_post
        if comment
          @comment_like = true
        else
          @comment_like = false
        end
      end
    
      def post
        @post = Post.find(params[:post_id])
      end
    
      def comment
        unless params[:comment_id].nil?
          @comment = post.comments.find(params[:comment_id])
        end
      end
end

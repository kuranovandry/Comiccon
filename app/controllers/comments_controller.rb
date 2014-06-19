class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    book = Book.find_by_id(comment_params[:book_id])
    if comment.save
      flash[:success] = "Comment posted!"
    else
      flash[:error] = "Error occured while posting comment, please try again!"
    end
    redirect_to book_path(book)
  end

  private
    def comment_params
      params[:comment].permit(:rating, :content, :book_id)
    end
end
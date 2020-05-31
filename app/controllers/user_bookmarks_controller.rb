class UserBookmarksController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.published.includes(:tags).sort_by_updated.page(params[:page])
  end
end

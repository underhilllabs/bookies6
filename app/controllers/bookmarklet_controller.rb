class BookmarkletController < ApplicationController
  def new
    @bookmark = Bookmark.find_or_initialize_by(user: current_user, address: params[:address])
    authorize @bookmark
  end
end

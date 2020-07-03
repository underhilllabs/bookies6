class SearchController < ApplicationController
  def index
    @keywords = params[:q]
    @q = Bookmark.ransack(title_cont: params[:q])
    @bookmarks = @q.result(distinct: true).order(updated_at: :DESC).page(params[:page])
  end
end

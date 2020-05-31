class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(taggings_count: :DESC).page(params[:page])
  end

  def show
    @tag = Tag.find(params[:id])
    @tag_name = @tag.name
    @bookmarks = @tag.bookmarks.sort_by_updated.page(params[:page])
  end

  def show_name
    @tag = Tag.find_by(name: params[:name])
    @bookmarks = Bookmark.tagged_with(params[:name]).sort_by_updated.page(params[:page])
    render :show
  end
    
end

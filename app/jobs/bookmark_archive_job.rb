class BookmarkArchiveJob < ApplicationJob

  def perform(bookmark_id)
    BookmarkArchiver.new(bookmark_id).call
  end
end

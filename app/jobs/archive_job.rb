class ArchiveJob < ApplicationJob

  def perform(bookmark_id)
    bookmark = Bookmark.find(bookmark_id)
    bookmark.archive_the_url
  end
end

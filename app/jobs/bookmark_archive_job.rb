class BookmarkArchiveJob < ApplicationJob

  def perform(bookmark)
    logger.info "archive job performed om bookmark #{bookmark.id} right now"
    BookmarkArchiver.new(bookmark).call
  end
end

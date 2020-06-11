class Bookmark < ApplicationRecord
  attr_accessor :is_popup
  before_save :archive_the_url, :hash_url
  belongs_to :user
  acts_as_taggable_on :tags

  validates_presence_of :address, :title, :user_id

  # Set default order: most recently updated
  scope :sort_by_updated, -> { order('updated_at DESC') }
  scope :published, -> { where(private: false) }
  scope :my_bookmarks, ->(user_id) { where(user_id: user_id) }
  # scope :published_or_mine,->(user_id) find_by_sql(.. UNION ..)
  scope :unpublished, -> { where(private: true) }
  scope :archived, -> { where(is_archived: true) }

  def self.build_from_json(json)
    b = Bookmark.find_or_initialize_by(id: json["id"])
    b.title = json["title"]
    b.address = json["address"]
    b.private = json["private"]
    b.description = json["description"]
    b.created_at = json["created_at"]
    b.updated_at = json["updated_at"] || json["created_at"]
    b.user_id = 1
    b.tag_list = json["tag_list"]
    b.save
  end

  private

  # download and archive the bookmark
  def archive_the_url
    if is_archived?
      logger.info "DISABLED: Queued the archiving of the url with id: #{id}"
      #Resque.enqueue(BookmarkArchiver, id)
    end
  end
 
  def hash_url
    self.hashed_url = Digest::MD5.hexdigest(address)
  end
end

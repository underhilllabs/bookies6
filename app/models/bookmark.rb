class Bookmark < ApplicationRecord
  attr_accessor :is_popup
  before_save :hash_url
  after_commit :archive_the_url
  belongs_to :user
  acts_as_taggable_on :tags

  delegate :username, to: :user, allow_nil: true
  validates_presence_of :address, :title, :user_id

  # Set default order: most recently updated
  scope :sort_by_updated, -> { order('updated_at DESC') }
  scope :published, -> { where(private: false) }
  scope :my_bookmarks, ->(user_id) { where(user_id: user_id) }
  scope :mine_or_published, ->(user_id) { my_bookmarks(user_id).or(published)}
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
    if is_archived? && !archive_url
      BookmarkArchiveJob.perform_later self
    end
  end
 
  def hash_url
    self.hashed_url = Digest::MD5.hexdigest(address)
  end
end

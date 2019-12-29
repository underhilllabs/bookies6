json.extract! bookmark, :id, :url, :hashed_url, :user_id, :desc, :title, :private, :is_archived, :archive_url, :created_at, :updated_at
json.url bookmark_url(bookmark, format: :json)

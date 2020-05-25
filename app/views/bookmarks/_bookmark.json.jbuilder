json.extract! bookmark, :id, :user_id, :address, :description, :title, :private, :tag_list, :created_at, :updated_at
json.url bookmark_url(bookmark, format: :json)

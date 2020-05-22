class AddTagStrToBookmarks < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmarks, :tag_str, :string
  end
end

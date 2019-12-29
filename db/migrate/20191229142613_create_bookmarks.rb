class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :hashed_url
      t.references :user, null: false, foreign_key: true
      t.text :desc
      t.string :title
      t.boolean :private
      t.boolean :is_archived
      t.string :archive_url

      t.timestamps
    end
  end
end

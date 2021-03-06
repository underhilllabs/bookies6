require 'open-uri'
require 'readability'

class BookmarkArchiver
  def initialize(bookmark)
    puts "no bookmark" unless bookmark
    puts "called initialize with bookmark #{bookmark.id} right now"
    @bookmark = bookmark
  end

  def call
    source = open(@bookmark.address).read
    content = Readability::Document.new(source).content
    archive_url  = "archive/#{@bookmark.id}.html"
    File.open("public/#{archive_url}", "w") do |f|
      f.puts content
    end
    @bookmark.is_archived = true
    @bookmark.archive_url = archive_url
    @bookmark.save
  end
end

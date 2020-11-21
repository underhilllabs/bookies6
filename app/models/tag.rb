class Tag < ApplicationRecord
  has_many :bookmarks
  def to_s
    "#{name}"
  end

  def count
  end
end

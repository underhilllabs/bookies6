require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:bookmark) { Bookmark.new}
  let(:user) { User.create email: "test@test.com", password: "tester" }
  it "is valid with valid attributes" do
    bookmark.title = "test"
    bookmark.address = "test"
    bookmark.user = user
    expect(bookmark).to be_valid
  end
  it "is not valid without an address" do 
    bookmark.title = "test"
    bookmark.address = nil
    bookmark.user = user
    expect(bookmark).to_not be_valid
  end
  it "is not valid without a title" do
    bookmark.title = nil
    bookmark.address = "test"
    bookmark.user = user
    expect(bookmark).to_not be_valid
  end
  it "is valid without a description" do
    bookmark.title = "test"
    bookmark.address = "test"
    bookmark.user = user
    bookmark.description = nil
    expect(bookmark).to be_valid
  end
  it "is not valid without a user" do
    bookmark.title = "test"
    bookmark.address = "test"
    expect(bookmark).to_not be_valid 
  end
end

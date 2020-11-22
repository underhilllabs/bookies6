require 'rails_helper'

RSpec.describe "the bookmarks page", type: :feature do
  before :context do
    User.create(email: 'user@example.com', password: 'password')
    User.create(email: 'user2@example.com', password: 'password')
    Bookmark.create(title: 'private bookmark', private: true, address: 'http://private.org', user_id: 1)
    Bookmark.create(title: 'private2 bookmark', private: true, address: 'http://private.org', user_id: 2)
    Bookmark.create(title: 'public bookmark', private: false, address: 'http://bigox.org', user_id: 1)
  end

  it "shows anonymous user public bookmarks" do
    visit "/"
    expect(page).to have_content 'public bookmark'
  end

  it "does not show anonymous user private bookmarks" do
    visit "/"
    expect(page).to_not have_content 'private bookmark'
  end

  it "shows authenticated user their private bookmarks" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'

    visit "/"
    expect(page).to have_content 'public bookmark'
    expect(page).to have_content 'private bookmark'
  end

  it "does mot shows authenticated user other private bookmarks" do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'

    visit "/"
    expect(page).to_not have_content 'private2 bookmark'
  end
end

require 'rails_helper'

RSpec.describe "the signin process", type: :feature do
  #let(:user) { User.create(email: 'user@example.com', password: 'password') }
  before :all do
    User.create(email: 'user@example.com', password: 'password')
  end

  it "signs me in" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'

  end
  it "reports incorrect sign in" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: "test@fm.com"
      fill_in 'Password', with: "passowrd"
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'

  end
end

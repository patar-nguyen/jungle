require 'rails_helper'

RSpec.feature "Visitor signs in with account", type: :feature, js: true do
  before :each do
    @user = User.create(
      name: 'Wumbo',
      email: 'wumbo@gmail.com',
      password: 'Wumbology',
      password_confirmation: 'Wumbology'
    )
  end

  scenario "They see product details" do
    # ACT
    visit root_path

    click_on 'Login'
    fill_in :email, with: 'wumbo@gmail.com'
    fill_in :password, with: 'Wumbology'
    # save_screenshot
    click_on 'Submit'
    expect(page).to have_content('Logout')
    # save_screenshot

  end
end

require 'rails_helper'

RSpec.feature "Visitor adds item to cart and updates cart number", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'
    @category.products.create!(
    name:  Faker::Hipster.sentence(3),
    description: Faker::Hipster.paragraph(4),
    image: open_asset('apparel1.jpg'),
    quantity: 10,
    price: 64.99
    )
  end

  scenario "They see product details" do
    # ACT
    visit root_path

    expect(page).to have_content('My Cart (0)')
    # DEBUG / VERIFY
    # save_screenshot


    click_on 'Add'

    expect(page).to have_content('My Cart (1)')

    # DEBUG / VERIFY
    # save_screenshot

  end
end

require 'rails_helper'

feature "Admin edits promotion" do
  scenario 'edit promotion' do
    user = User.create!(email: 'matheus@email.com', password: '123456')
    promotion = Promotion.create!(name: "Natal", description: "Promoção de Natal",
      code: "NATAL10", discount_rate: 10, coupon_quantity: 100,
      expiration_date: "22/12/2033", user: user)
      login_as user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on "Editar"

    fill_in 'Nome', with: 'Natal 2021'
    click_on 'Salvar'

    expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('Natal 2021')
  end
end
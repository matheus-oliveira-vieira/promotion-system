require "rails_helper"

feature "Admin generate coupons" do
  scenario 'of a promotion' do
    user = User.create!(email: 'matheus@email.com', password: '123456')
    promotion = Promotion.create!(name: "Natal", description: "Promoção de Natal",
      code: "NATAL10", discount_rate: 10, coupon_quantity: 100,
      expiration_date: "22/12/2033", user: user)
      login_as user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Gerar Cupons'
    expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).to have_content('NATAL10-0001')
    expect(page).to have_content('NATAL10-0002')
    expect(page).to have_content('NATAL10-0100')
    expect(page).not_to have_content('NATAL10-0101')
  end

  # scenario 'hide button if coupons generated' do
  
  # end

  #ver rails notes
end
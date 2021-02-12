require 'rails_helper'

feature 'Visit home page' do
  context 'and search for book' do
    scenario 'successfully' do
      user = User.create!(email: 'matheus@email.com', password: '123456')
      Promotion.create!(name: "Natal", description: "Promoção de Natal",
        code: "NATAL10", discount_rate: 10, coupon_quantity: 100,
        expiration_date: "22/12/2033", user: user)
      Promotion.create!(name: "Cyber Monday", coupon_quantity: 90,
        description: "Promoção de Cyber Monday",
        code: "CYBER15", discount_rate: 15,
        expiration_date: "22/12/2033", user: user)
      Promotion.create!(name: "São João", coupon_quantity: 50,
        description: "São João com quentão de montão",
        code: "JOAO15", discount_rate: 15,
        expiration_date: "22/12/2033", user: user)
      visit root_path
      login_as user
      click_on "Promoções"
      fill_in 'Busca:', with: 'Promoção' #critérios de busca usando nome e descriprion
      click_on 'Pesquisar'
      expect(current_path).to eq search_path
      expect(page).to have_content('Natal')
      expect(page).to have_content('Promoção de Natal')
      expect(page).to have_content('Cyber Monday')
      expect(page).to have_content('Promoção de Cyber Monday')
      expect(page).not_to have_content('São João')
      expect(page).not_to have_content('São João com quentão de montão')
    end
  end
end
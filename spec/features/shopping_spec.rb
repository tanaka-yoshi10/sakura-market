require 'rails_helper'

feature 'ショッピング機能' do
  background do
    ShipTime.create!(shiptime_code: '00', display_name: '未指定')
    create(:product_tomato)
    user_1 = create(:user_1)
    create(:address, user: user_1)
    create(:cod_charge_01)
    create(:cod_charge_02)
    create(:cod_charge_03)
    create(:cod_charge_04)
  end

  scenario '商品一覧を表示する' do
    user_1 = build(:user_1)
    normal_sign_in(user_1)

    #save_and_open_page

    expect(page).to have_content 'さくらマーケット'
    expect(page).to have_content '長野産とまと(6個入り)'
  end

  scenario '商品をカートに入れる' do
    user_1 = build(:user_1)
    normal_sign_in(user_1)

    fill_in 'quantity-0', with: '2'
    click_button 'add-cart-0'

    click_link 'カートを見る'

    #save_and_open_page
    expect(page).to have_link '注文を確定する'
    expect(page).to have_content '長野産とまと(6個入り)'
    expect(page).to have_field 'quantity-0', with: '2'

  end

  scenario 'カートで注文を確定する' do
    user_1 = build(:user_1)
    normal_sign_in(user_1)

    fill_in 'quantity-0', with: '2'
    click_button 'add-cart-0'

    click_link 'カートを見る'

    click_link '注文を確定する'
    #save_and_open_page

  end
end

require 'rails_helper'

feature '管理者の商品一覧機能' do
  background do
    ShipTime.create!(shiptime_code: '00', display_name: '未指定')
    create(:product_tomato)
  end

  scenario '商品一覧を表示する' do
    admin = create(:user_admin)
    admin_sign_in(admin)

    click_link '商品管理'

    #save_and_open_page
    expect(page).to have_content '長野産とまと(6個入り)'
  end
end

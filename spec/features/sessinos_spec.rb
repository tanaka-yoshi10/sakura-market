require 'rails_helper'

feature 'ログインとログアウト' do
  background do
    create(:product_tomato)
    ShipTime.create!(shiptime_code: '00', display_name: '未指定')
  end

  scenario '管理者としてログインする' do
    admin = create(:user_admin)
    admin_sign_in(admin)

    #save_and_open_page

    # ログインに成功したことを検証する
    expect(page).to have_content 'ユーザ一覧'
  end
  scenario '一般ユーザとしてログインする' do
    user = create(:user_normal)
    normal_sign_in(user)

    #save_and_open_page

    expect(page).to have_content '長野産とまと(6個入り)'
  end
end

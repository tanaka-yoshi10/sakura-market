require 'rails_helper'

feature '管理者のユーザ管理機能' do
  background do
    ShipTime.create!(shiptime_code: '00', display_name: '未指定')
    create(:user_1)
  end

  scenario 'ユーザ一覧を表示する' do
    # [review] backgroundに書いて共通化してはどうでしょうか。
    admin = create(:user_admin)
    admin_sign_in(admin)

    #save_and_open_page
    click_link 'ユーザ管理'

    expect(page).to have_content 'ユーザ一覧'
  end
  scenario 'ユーザ詳細を表示する' do
    admin = create(:user_admin)
    admin_sign_in(admin)

    click_link 'ユーザ管理'

    all('tbody tr')[0].click_link '詳細'
    #save_and_open_page
    expect(page).to have_content 'ユーザ情報'
  end
  scenario 'ユーザ編集画面を表示する' do
    admin = create(:user_admin)
    admin_sign_in(admin)

    click_link 'ユーザ管理'

    all('tbody tr')[0].click_link '編集'
    #save_and_open_page
    expect(page).to have_content 'ユーザ編集'
  end
  scenario 'ユーザの名前を変更する' do
    admin = create(:user_admin)
    admin_sign_in(admin)

    click_link 'ユーザ管理'

    all('tbody tr')[0].click_link '編集'

    fill_in '名前', with: '変更後の名前'
    fill_in 'user_password', with: admin.password
    fill_in 'user_password_confirmation', with: admin.password

    click_button '更新する'

    #save_and_open_page
    expect(page).to have_content 'ユーザ情報'
    expect(page).to have_content '変更後の名前'
  end
end

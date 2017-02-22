module LoginMacros

  def admin_sign_in(user)
    # 管理者ページを開く
    visit admin_admins_path

    # ログインフォームにEmailとパスワードを入力する
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password

    # ログインボタンをクリックする
    click_button 'ログイン'
  end

  def normal_sign_in(user)
    # トップページを開く
    visit session_path

    # ログインフォームにEmailとパスワードを入力する
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password

    # ログインボタンをクリックする
    click_button 'ログイン'
  end
end
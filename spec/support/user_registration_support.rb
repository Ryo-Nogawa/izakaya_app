module  UserRegistrationSupport
  def user_regitstration(user)
    # 新規登録ページへ移動する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in "user_nickname", with: user.nickname
    fill_in "user_name", with: user.name
    fill_in "user_name_kana", with: user.name_kana
    fill_in "user_age", with: user.age
    fill_in "user_phone_number", with: user.phone_number
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    # 確認画面ボタンを押すと今入力した情報を確認できる
    find('input[name="commit"]').click
    # 登録するボタンを押すとユーザーモデルのカウントが1上がることを確認する
    expect do
      find('input[name="commit"]').click
    end.to change { User.count }.by(1)
    # ログインボタンをクリックする
    find_link('ログイン画面', href: root_path).click
  end
end
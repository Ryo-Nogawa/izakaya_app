module  UserRegistrationSupport
  def user_regitstration(user)
    # 新規登録ページへ移動する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in 'user[nickname]', with: user.nickname
    fill_in 'user[name]', with: user.name
    fill_in 'user[name_kana]', with: user.name_kana
    fill_in 'user[age]', with: user.age
    fill_in 'user[phone_number]', with: user.phone_number
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
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
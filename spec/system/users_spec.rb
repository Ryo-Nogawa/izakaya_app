require 'rails_helper'

def basic_auth(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end 

  context 'ユーザー新規登録できるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # basic認証を入力する
        basic_auth new_user_session_path
      # 新規登録ページへ移動する
        visit new_user_registration_path
      # ユーザー情報を入力する
        fill_in 'user[nickname]', with: @user.nickname
        fill_in 'user[name]', with: @user.name
        fill_in 'user[name_kana]', with: @user.name_kana
        fill_in 'user[age]', with: @user.age
        fill_in 'user[phone_number]', with: @user.phone_number
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        fill_in 'user[password_confirmation]', with: @user.password_confirmation
      # 確認画面ボタンを押すと今入力した情報を確認できる
        find('input[name="commit"]').click
      # 登録するボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect{
          find('input[name="commit"]').click
        }.to change {User.count}.by(1)
      # ログインボタンをクリックする
        find_link('ログイン画面', href: root_path).click
      # sign_in情報を入力する
        sign_in(@user)
      # ログアウトボタンが表示されていることを確認する
        expect(page).to have_content('ログアウト')
      # ログインボタンや新規登録ボタンが表示されていないことを確認する
        expect(page).to have_no_content('ログイン')
        expect(page).to have_no_content('新規登録')
    end
  end
  context '新規登録がうまくいかない場合' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # basic認証を入力する
        basic_auth new_user_session_path
      # 新規登録ページへ移動する
        visit new_user_registration_path
      # ユーザー情報を入力する
        fill_in 'user[nickname]', with: ""
        fill_in 'user[name]', with: ""
        fill_in 'user[name_kana]', with: ""
        fill_in 'user[age]', with: ""
        fill_in 'user[phone_number]', with: ""
        fill_in 'user[email]', with: ""
        fill_in 'user[password]', with: ""
        fill_in 'user[password_confirmation]', with: ""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change {User.count}.by(0)
      # 新規登録ページへ戻されることを確認する
        expect(current_path).to eq "/users/sign_up/confirm"
    end
  end
end

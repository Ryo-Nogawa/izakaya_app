# frozen_string_literal: true

require 'rails_helper'

def basic_auth(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe '予約', type: :system do
  before do
    @book = FactoryBot.build(:book)
    @user = FactoryBot.build(:user)
  end

  context '予約が完了するとき' do
    it 'ログインしたユーザーは予約することができる' do
      # basic認証を入力する
      basic_auth new_user_session_path
      # ユーザー登録
      user_regitstration(@user)
      # sign_in情報を入力する
      sign_in(@user)
      # 予約ページへのリンクがあることを確認する
      expect(page).to have_content('ご予約はこちらから')
      # 予約ページに移動する
      find_link('ご予約はこちらから', href: '/books/new').click
      # フォームに情報を入力する
      fill_in 'book[reserve_date]', with: @book.reserve_date
      select '17', from: 'book[reserve_time(4i)]'
      select '00', from: 'book[reserve_time(5i)]'
      fill_in 'book[number_reserve]', with: @book.number_reserve
      select 'お席のみ', from: 'book[reserve_category_id]'
      # 確認画面ボタンを押す
      find('input[name="commit"]').click
      # 確認画面に遷移していることを確認する
      expect(current_path).to eq confirm_books_path
      # 予約するボタンを押すとBookモデルのカウントが1上がることを確認する
      expect do
        find('input[value="予約する"]').click
      end.to change { Book.count }.by(1)
      # 予約完了ページに遷移することを確認する
      expect(current_path).to eq complete_books_path
      # 「ご予約が完了しました」の文字があることを確認する
      expect(page).to have_content('ご予約が完了しました')
      # トップページへ遷移する
      find_link('トップページへ戻る', href: root_path).click
    end
  end
  context '予約がうまくいかないとき' do
    it '入力フォームが空の時' do
      # ユーザー新規登録
      user_regitstration(@user)
      # sign_in情報を入力する
      sign_in(@user)
      # 予約ページへのリンクがあることを確認する
      expect(page).to have_content('ご予約はこちらから')
      # 予約ページに移動する
      find_link('ご予約はこちらから', href: '/books/new').click
      # 入力フォームが空
      fill_in 'book[reserve_date]', with: Date.today
      select '-----', from: 'book[reserve_time(4i)]'
      select '-----', from: 'book[reserve_time(5i)]'
      fill_in 'book[number_reserve]', with: ''
      select '選択してください', from: 'book[reserve_category_id]'
      # 確認画面ボタンを押す
      find('input[name="commit"]').click
      # 予約ページに戻ってくる
      expect(current_path).to eq confirm_books_path
    end
  end
end

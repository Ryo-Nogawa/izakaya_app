require 'rails_helper'

def basic_auth(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'メッセージ', type: :system do
  before do
    @message = FactoryBot.build(:message)
    @user = FactoryBot.build(:user)
  end

  # seedファイルの読み込み
  before(:each) do
    load Rails.root.join("db/seeds.rb")
  end

  context 'メッセージ送信が完了するとき' do
    it 'メッセージ内容を入力したら送信できる' do
      # basic認証を入力する
      basic_auth new_user_session_path
      # ユーザー登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ご意見/ご要望ページへ遷移する
      expect(page).to have_content("ご意見/ご要望")
      visit messages_path
      # メッセージ内容を入力する
      fill_in "message[content]", with: @message.content
      # 送信ボタンをクリックする
      find(".message-btn").click
      # 送信した内容が表示されている
      expect(page).to have_content(@message.content)
    end

    it 'メッセージ内容を入力した内容が削除できる' do
      # ユーザー登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ご意見/ご要望ページへ遷移する
      expect(page).to have_content("ご意見/ご要望")
      visit messages_path
      # メッセージ内容を入力する
      fill_in "message[content]", with: @message.content
      # 送信ボタンをクリックする
      find(".message-btn").click
      # 送信した内容が表示されている
      expect(page).to have_content(@message.content)
      # 削除ボタンがあることを確認する
      find(".trash-icon").click
    end
  end
end
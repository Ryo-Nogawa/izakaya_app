require 'rails_helper'

def basic_auth(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'フード', type: :system do
  before do
    @food = FactoryBot.build(:food)
    @user = FactoryBot.build(:user)
  end
  #seedファイルを読み込む
  before(:each) do
    load Rails.root.join("db/seeds.rb")
  end


  context 'フード投稿が完了するとき' do
    it 'adminでログインしたときに投稿することができる' do
      # basic認証を入力する
      basic_auth new_user_session_path
      # adminでログインする
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content("お料理")
      visit foods_path
      # 新規投稿ボタンをクリック
      find_link('新規作成', href: new_food_path).click
      expect(current_path).to eq new_food_path
      # フォームを入力する
      fill_in 'food[title]', with: @food.title
      fill_in 'food[detail]', with: @food.detail
      fill_in 'food[price]', with: @food.price
      select '今月のおすすめ', from: 'food[food_category_id]'
      attach_file('food[image]', 'public/images/test_image.png', make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Food.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # ドリンク一覧ページに投稿した内容が存在する
      find_link('一覧へ戻る', href: foods_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.price)
      expect(page).to have_content('今月のおすすめ')
    end
  end

  context 'フードの投稿ができないとき' do
    it 'admin以外でログインしているときは新規投稿ボタンが存在しない' do
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ドリンク一覧ページへ遷移する
      expect(page).to have_content("お料理")
      visit foods_path
      # 新規投稿ボタンがないことを確認する
      expect(page).to have_no_content("新規作成")
    end
  end
end
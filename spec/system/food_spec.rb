# frozen_string_literal: true

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
  # seedファイルを読み込む
  before(:each) do
    load Rails.root.join('db/seeds.rb')
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
      expect(page).to have_content('お料理')
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
      expect(page).to have_content('投稿が完了しました')
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
      expect(page).to have_content('お料理')
      visit foods_path
      # 新規投稿ボタンがないことを確認する
      expect(page).to have_no_content('新規作成')
    end
  end

  context "フードの編集" do
    it "adminでログインしているときに詳細ページから編集できる" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お料理ボタンをクリックする
      expect(page).to have_content("お料理")
      visit foods_path
      # 新規作成ボタンをクリックする
      find_link("新規作成", href: new_food_path).click
      expect(current_path).to eq new_food_path
      # フォームを入力する
      fill_in "food[title]", with: @food.title
      fill_in "food[detail]", with: @food.detail
      fill_in "food[price]", with: @food.price
      select "今月のおすすめ", from: "food[food_category_id]"
      attach_file("food[image]", "public/images/test_image.png", make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Food.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # フード一覧ページに投稿した内容が存在することを確認する
      find_link("一覧へ戻る", href: foods_path).click 
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.price)
      expect(page).to have_content("今月のおすすめ")
      # フードの画像をクリックする
      find(".index-content-image").click 
      # 投稿した内容があるのか確認する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.detail)
      expect(page).to have_content(@food.price)
      expect(page).to have_content("今月のおすすめ")
      # 編集ボタンをクリックする
      click_on "編集"
      # 編集内容を入力する
      fill_in "food[title]", with: @food.title
      fill_in "food[detail]", with: @food.detail
      fill_in "food[price]", with: @food.price
      # 投稿するボタンをクリックする
      expect do
        find('input[value="投稿する"]').click
      end.to change { Food.count }.by(0)
      # 編集完了ページに遷移することを確認する
      expect(page).to have_content("編集が完了しました")
      # 詳細画面に戻り、編集した内容が存在するかを確認する
      click_on "詳細へ戻る"
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.detail)
      expect(page).to have_content(@food.price)
      expect(page).to have_content("今月のおすすめ")
    end
  end

  context "フードの編集ができない時" do
    it "admin以外でログインしている時" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click 
      expect(current_path).to eq root_path
      # お料理ボタンをクリック
      expect(page).to have_content("お料理")
      visit foods_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_food_path).click 
      expect(current_path).to eq new_food_path
      # フォームを入力する
      fill_in "food[title]", with: @food.title
      fill_in "food[detail]", with: @food.detail
      fill_in "food[price]", with: @food.price
      select "今月のおすすめ", from: "food[food_category_id]"
      attach_file("food[image]", "public/images/test_image.png", make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Food.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # フード一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: foods_path).click 
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.price)
      expect(page).to have_content("今月のおすすめ")
      # ログアウトする
      click_on "ログアウト"
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # フード一覧ページへ遷移する
      expect(page).to have_content("お料理")
      visit foods_path
      # メニューの画像をクリックする
      find(".index-content-image").click 
      # 編集ボタンがないことを確認する
      expect(page).to have_no_content("編集")
    end
  end

  context "投稿が削除できる時" do
    it "adminでログインしているときは削除できる" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click 
      expect(current_path).to eq root_path
      # お料理ボタンをクリック
      expect(page).to have_content("お料理")
      visit foods_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_food_path).click 
      expect(current_path).to eq new_food_path
      # フォームを入力する
      fill_in "food[title]", with: @food.title
      fill_in "food[detail]", with: @food.detail
      fill_in "food[price]", with: @food.price
      select "今月のおすすめ", from: "food[food_category_id]"
      attach_file("food[image]", "public/images/test_image.png", make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Food.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # フード一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: foods_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.price)
      expect(page).to have_content("今月のおすすめ")
      # 詳細ページへ遷移する
      find(".index-content-image").click 
      # 投稿した内容があるかを確認する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.detail)
      expect(page).to have_content(@food.price)
      expect(page).to have_content("今月のおすすめ")
      # 削除ボタンをクリックする
      click_on "削除"
      # 削除完了ページへ遷移する
      expect(page).to have_content("投稿の削除が完了しました")
      # 一覧ページに戻り、削除されているかを確認する
      click_on "一覧へ戻る"
      expect(page).to have_no_selector("img[src$='test_image.png']")
      expect(page).to have_no_content(@food.title)
      expect(page).to have_no_content(@food.price)
    end
  end

  context "削除ができない時" do
    it "admin以外でログインしているときは削除できない" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click 
      expect(current_path).to eq root_path
      # お料理ボタンをクリック
      expect(page).to have_content("お料理")
      visit foods_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_food_path).click 
      expect(current_path).to eq new_food_path
      # フォームを入力する
      fill_in "food[title]", with: @food.title
      fill_in "food[detail]", with: @food.detail
      fill_in "food[price]", with: @food.price
      select "今月のおすすめ", from: "food[food_category_id]"
      attach_file("food[image]", "public/images/test_image.png", make_visible: true)
      # 投稿するボタンをクリックする
      expect do
        find('input[value="投稿する"]').click
      end.to change { Food.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # フード一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: foods_path).click 
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.price)
      expect(page).to have_content("今月のおすすめ")
      # ログアウトする
      click_on "ログアウト"
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # フード一覧ページへ遷移する
      expect(page).to have_content("お料理")
      visit foods_path
      # メニューの画像をクリックする
      find(".index-content-image").click 
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content("削除")
    end
  end

  context "フードメニューにコメントを残す" do
    it "入力内容があればコメントを残すことができる" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click 
      expect(current_path).to eq root_path
      # お料理ボタンをクリックする
      expect(page).to have_content("お料理")
      visit foods_path
      # 新規作成ボタンをクリックする
      find_link("新規作成", href: new_food_path).click 
      expect(current_path).to eq new_food_path
      # フォームを入力する
      fill_in "food[title]", with: @food.title
      fill_in "food[detail]", with: @food.detail
      fill_in "food[price]", with: @food.price
      select "今月のおすすめ", from: "food[food_category_id]"
      attach_file("food[image]", "public/images/test_image.png", make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Food.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # フード一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: foods_path).click 
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.price)
      expect(page).to have_content("今月のおすすめ")
      # ログアウトする
      click_on "ログアウト"
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # フード一覧ページへ遷移する
      expect(page).to have_content("お料理")
      visit foods_path
      # メニューの画像をクリックする
      find(".index-content-image").click 
      # コメント欄にコメント内容を入力する
      fill_in "food_comment[comment]", with: Faker::Lorem.characters(number: 100)
      # 送信ボタンをクリックする
      find(".comment-submit").click 
    end
  end

  context "お気に入りボタンをクリックするとカウントが1上がる" do
    it "投稿内容のハートボタンをクリックする" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click 
      expect(current_path).to eq root_path
      # お料理ボタンをクリックする
      expect(page).to have_content("お料理")
      visit foods_path
      # 新規作成ボタンをクリックする
      find_link("新規作成", href: new_food_path).click 
      expect(current_path).to eq new_food_path
      # フォームを入力する
      fill_in "food[title]", with: @food.title
      fill_in "food[detail]", with: @food.detail
      fill_in "food[price]", with: @food.price
      select "今月のおすすめ", from: "food[food_category_id]"
      attach_file("food[image]", "public/images/test_image.png", make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Food.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # フード一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: foods_path).click 
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@food.title)
      expect(page).to have_content(@food.price)
      expect(page).to have_content("今月のおすすめ")
      # ハートボタンをクリックする
      expect do
        first(".fa-heart").click
        # 0.1秒間停止させる
        sleep(0.1)
      end.to change {FoodLike.count}.by(1)
      # ハートボタンをもう一度クリックするとカウントが1減る
      expect do
        first(".fa-heart").click
        sleep(0.1)
      end.to change { FoodLike.count }.by(-1)
    end
  end
end

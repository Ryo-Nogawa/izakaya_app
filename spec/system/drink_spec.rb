# frozen_string_literal: true

require 'rails_helper'

def basic_auth(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'ドリンク', type: :system do
  before do
    @drink = FactoryBot.build(:drink)
    @user = FactoryBot.build(:user)
  end
  # seedファイルを読み込む
  before(:each) do
    load Rails.root.join('db/seeds.rb')
  end

  context 'ドリンクの投稿が完了するとき' do
    it 'adminでログインしたときに投稿することができる' do
      # basic認証を入力する
      basic_auth new_user_session_path
      # adminでログインする
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # 新規投稿ボタンをクリック
      find_link('新規作成', href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in 'drink[title]', with: @drink.title
      fill_in 'drink[detail]', with: @drink.detail
      fill_in 'drink[price]', with: @drink.price
      select 'ビール', from: 'drink[drink_category_id]'
      attach_file('drink[image]', 'public/images/test_image.png', make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content('投稿が完了しました')
      # ドリンク一覧ページに投稿した内容が存在する
      find_link('一覧へ戻る', href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
    end
  end

  context 'ドリンクの投稿が出来ないとき' do
    it 'admin以外でログインしているときは新規投稿ボタンが存在しない' do
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ドリンク一覧ページへ遷移する
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # 新規投稿ボタンがないことを確認する
      expect(page).to have_no_content('新規投稿')
    end
  end

  context 'ドリンクの編集' do
    it 'adminでログインしているときに詳細ページから編集できる' do
      # adminでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # 新規投稿ボタンをクリック
      find_link('新規作成', href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in 'drink[title]', with: @drink.title
      fill_in 'drink[detail]', with: @drink.detail
      fill_in 'drink[price]', with: @drink.price
      select 'ビール', from: 'drink[drink_category_id]'
      attach_file('drink[image]', 'public/images/test_image.png', make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content('投稿が完了しました')
      # ドリンク一覧ページに投稿した内容が存在する
      find_link('一覧へ戻る', href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
      # ドリンクの画像をクリックする
      find(".index-content-image").click
      # 投稿した内容があるか確認する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.detail)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
      # 編集ボタンをクリックする
      click_on "編集"
      # 編集内容を入力する
      fill_in 'drink[title]', with: @drink.title
      fill_in 'drink[detail]', with: @drink.detail
      fill_in 'drink[price]', with: @drink.price
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(0)
      # 編集完了ページに遷移することを確認する
      expect(page).to have_content("編集が完了しました")
      # 詳細画面に戻り編集した内容が存在するかを確認する
      click_on "詳細へ戻る"
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.detail)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
    end
  end

  context "ドリンクの編集ができないとき" do
    it "admin以外でログインしている時" do
      # adminでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # 新規投稿ボタンをクリック
      find_link('新規作成', href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in 'drink[title]', with: @drink.title
      fill_in 'drink[detail]', with: @drink.detail
      fill_in 'drink[price]', with: @drink.price
      select 'ビール', from: 'drink[drink_category_id]'
      attach_file('drink[image]', 'public/images/test_image.png', make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content('投稿が完了しました')
      # ドリンク一覧ページに投稿した内容が存在する
      find_link('一覧へ戻る', href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
      # ログアウトする
      click_on "ログアウト"
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ドリンク一覧ページへ遷移する
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # メニューの画像をクリックする
      find(".index-content-image").click
      # 編集ボタンがないことを確認する
      expect(page).to have_no_content("編集")
    end
  end

  context "投稿の削除ができる時" do
    it "adminでログインしている時は削除できる" do
      # adminでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # 新規投稿ボタンをクリック
      find_link('新規作成', href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in 'drink[title]', with: @drink.title
      fill_in 'drink[detail]', with: @drink.detail
      fill_in 'drink[price]', with: @drink.price
      select 'ビール', from: 'drink[drink_category_id]'
      attach_file('drink[image]', 'public/images/test_image.png', make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content('投稿が完了しました')
      # ドリンク一覧ページに投稿した内容が存在する
      find_link('一覧へ戻る', href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
      # 詳細ページへ遷移する
      find(".index-content-image").click
      # 投稿した内容があるか確認する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.detail)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
      # 削除ボタンをクリックする
      click_on "削除"
      # 削除完了ページへ遷移する
      expect(page).to have_content("投稿の削除が完了しました")
      # 一覧ページに戻り、削除されているか確認する
      click_on "一覧へ戻る"
      expect(page).to have_no_selector("img[src$='test_image.png']")
      expect(page).to have_no_content(@drink.title)
      expect(page).to have_no_content(@drink.price)
    end
  end

  context "削除ができない時" do
    it "admin以外でログインしているときは削除できない" do
      # adminでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # 新規投稿ボタンをクリック
      find_link('新規作成', href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in 'drink[title]', with: @drink.title
      fill_in 'drink[detail]', with: @drink.detail
      fill_in 'drink[price]', with: @drink.price
      select 'ビール', from: 'drink[drink_category_id]'
      attach_file('drink[image]', 'public/images/test_image.png', make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content('投稿が完了しました')
      # ドリンク一覧ページに投稿した内容が存在する
      find_link('一覧へ戻る', href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
      # ログアウトする
      click_on "ログアウト"
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ドリンク一覧ページへ遷移する
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # メニューの画像をクリックする
      find(".index-content-image").click
      # 編集ボタンがないことを確認する
      expect(page).to have_no_content("削除")
    end
  end

  context "ドリンクメニューにコメントを残す" do
    it "入力内容があればコメントを残すことができる" do
      # adminでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # 新規投稿ボタンをクリック
      find_link('新規作成', href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in 'drink[title]', with: @drink.title
      fill_in 'drink[detail]', with: @drink.detail
      fill_in 'drink[price]', with: @drink.price
      select 'ビール', from: 'drink[drink_category_id]'
      attach_file('drink[image]', 'public/images/test_image.png', make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content('投稿が完了しました')
      # ドリンク一覧ページに投稿した内容が存在する
      find_link('一覧へ戻る', href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
      # ログアウトする
      click_on "ログアウト"
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ドリンク一覧ページへ遷移する
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # メニューの画像をクリックする
      find(".index-content-image").click
      # コメント欄にコメントを入力する
      fill_in "drink_comment[comment]", with: Faker::Lorem.characters(number: 100)
      # 送信ボタンをクリック
      find(".comment-submit").click
    end
  end

  context "お気に入りボタン" do
    it "投稿内容のハートボタンをクリックするとDrinkLikeのカウントが1上がる" do
      # adminでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # 新規投稿ボタンをクリック
      find_link('新規作成', href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in 'drink[title]', with: @drink.title
      fill_in 'drink[detail]', with: @drink.detail
      fill_in 'drink[price]', with: @drink.price
      select 'ビール', from: 'drink[drink_category_id]'
      attach_file('drink[image]', 'public/images/test_image.png', make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content('投稿が完了しました')
      # ドリンク一覧ページに投稿した内容が存在する
      find_link('一覧へ戻る', href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content('ビール')
      # ハートボタンをクリックする
      expect do
        first(".fa-heart").click
        sleep(0.1)
      end.to change { DrinkLike.count }.by(1)
      expect(page).to have_content("1")
      # ログアウトする
      click_on "ログアウト"
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ドリンク一覧ページへ遷移する
      expect(page).to have_content('お飲み物')
      visit drinks_path
      # ハートボタンをクリックする
      expect do
        first(".fa-heart").click
        sleep(0.1)
      end.to change { DrinkLike.count }.by(1)
      expect(page).to have_content("2")
      # もう一度ハートボタンをクリックする
      expect do
        first(".fa-heart").click 
        sleep(0.1)
      end.to change { DrinkLike.count }.by(-1)
      expect(page).to have_content("1")
    end
  end

  context "ドリンク検索" do
    it "カテゴリーと検索ボタンが一致した場合に表示する" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content("お飲み物")
      visit drinks_path
      # 新規投稿ボタンをクリック
      find_link("新規作成", href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in "drink[title]", with: @drink.title
      fill_in "drink[detail]", with: @drink.detail
      fill_in "drink[price]", with: @drink.price
      select "ビール", from: "drink[drink_category_id]"
      attach_file("drink[image]", "public/images/test_image.png", make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # ドリンク一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content("ビール")
      # ビールのラジオボタンをクリック
      find("#q_drink_category_id_eq_2").click
      click_on "検索"
      # 投稿した内容が存在する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content("ビール")
    end

    it "検索が該当しない時" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content("お飲み物")
      visit drinks_path
      # 新規投稿ボタンをクリック
      find_link("新規作成", href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in "drink[title]", with: @drink.title
      fill_in "drink[detail]", with: @drink.detail
      fill_in "drink[price]", with: @drink.price
      select "ビール", from: "drink[drink_category_id]"
      attach_file("drink[image]", "public/images/test_image.png", make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # ドリンク一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content("ビール")
      # ハイボールのラジオボタンをクリック
      find("#q_drink_category_id_eq_3").click
      click_on "検索"
      # 投稿した内容が存在しないことを確認する
      expect(page).to have_content("該当する商品がありませんでした")
    end
  end

  context "飲み放題" do
    it "飲み放題を許可する" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # お飲み物ボタンをクリック
      expect(page).to have_content("お飲み物")
      visit drinks_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_drink_path).click
      expect(current_path).to eq new_drink_path
      # フォームを入力する
      fill_in "drink[title]", with: @drink.title
      fill_in "drink[detail]", with: @drink.detail
      fill_in "drink[price]", with: @drink.price
      select "ビール", from: "drink[drink_category_id]"
      find("#drink_free_drink").click
      attach_file("drink[image]", "public/images/test_image.png", make_visible: true)
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Drink.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # ドリンク一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: drinks_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content("ビール")
      # 飲み放題のラベルが付いていることを確認する
      expect(page).to have_css(".caption")
      # 飲み放題のラジオボタンをクリック
      find("#q_free_drink_eq_1").click
      click_on "検索"
      # 投稿した内容が存在する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@drink.title)
      expect(page).to have_content(@drink.price)
      expect(page).to have_content("ビール")
      expect(page).to have_css(".caption")
    end
  end
end

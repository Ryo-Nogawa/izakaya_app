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

  context '内装/外観の投稿が完了する時' do
    it 'adminでログインしたときに投稿することができる' do
      # basic認証を入力する
      basic_auth new_user_session_path
      # adminでログインする
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 外観/内装ボタンをクリック
      expect(page).to have_content('外観/内装')
      visit visuals_path
      # 新規投稿ボタンをクリック
      find_link('新規作成', href: new_visual_path).click
      expect(current_path).to eq new_visual_path
      # フォームを入力する
      attach_file('visual[image]', 'public/images/test_image.png', make_visible: true)
      select '外観', from: 'visual[visual_category_id]'
      # 投稿するボタンをクリックする
      expect do
        find('input[value="投稿する"]').click
      end.to change { Visual.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content('投稿が完了しました')
      # 外観/内装一覧ページに投稿した内容が存在する
      find_link('一覧へ戻る', href: visuals_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
    end
  end

  context '外観/内装の投稿ができないとき' do
    it 'admin以外でログインしているときは新規作成ボタンが存在しない' do
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ドリンク一覧ページへ遷移する
      expect(page).to have_content('外観/内装')
      visit visuals_path
      # 新規投稿ボタンがないことを確認する
      expect(page).to have_no_content('新規作成')
    end
  end

  context "外観/内装の編集" do
    it "adminでログインしている時は編集できる" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 外観/内装ボタンをクリック
      expect(page).to have_content("外観/内装")
      visit visuals_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_visual_path).click
      expect(current_path).to eq new_visual_path
      # フォームを入力する
      attach_file("visual[image]", "public/images/test_image.png", make_visible: true)
      select "外観", from: "visual[visual_category_id]"
      # 投稿するボタンをクリックする
      expect do
        find('input[value="投稿する"]').click
      end.to change { Visual.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # 外観/内装一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: visuals_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      # 編集ボタンをクリックする
      click_on "編集"
      # フォーム内容を変更する
      select "内装", from: "visual[visual_category_id]"
      # 投稿するボタンをクリックする
      expect do
        find('input[value="投稿する"]').click
      end.to change { Visual.count }.by(0)
      # 編集完了ページに遷移する
      expect(page).to have_content("編集が完了しました")
    end

    it "admin以外でログインしている時は編集できない" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      # 外観/内装ボタンをクリック
      expect(page).to have_content("外観/内装")
      visit visuals_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_visual_path).click
      expect(current_path).to eq new_visual_path
      # フォームを入力する
      attach_file("visual[image]", "public/images/test_image.png", make_visible: true)
      select "外観", from: "visual[visual_category_id]"
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Visual.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # 外観/内装一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: visuals_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      # ログアウトする
      click_on "ログアウト"
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # 外観/内装一覧ページへ遷移する
      expect(page).to have_content("外観/内装")
      visit visuals_path
      # 編集ボタンがないことを確認する
      expect(page).to have_no_content("編集")
    end
  end

  context "外観/内装の削除" do
    it "adminでログインしている時は削除できる" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 外観/内装ボタンをクリックする
      expect(page).to have_content("外観/内装")
      visit visuals_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_visual_path).click
      expect(current_path).to eq new_visual_path
      # フォームを入力する
      attach_file("visual[image]", "public/images/test_image.png", make_visible: true)
      select "外観", from: "visual[visual_category_id]"
      # 投稿するボタンをクリックする
      expect do
        find('input[value="投稿する"]').click
      end.to change { Visual.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # 外観/内装一覧ページに投稿した内容が存在することを確認する
      find_link("一覧へ戻る", href: visuals_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      # 削除ボタンをクリックする
      expect do
        click_on "削除"
      end.to change { Visual.count }.by(-1)
      # 削除完了ページに遷移する
      expect(page).to have_content("投稿の削除が完了しました")
      # 一覧へ戻り投稿がないことを確認する
      find_link("一覧へ戻る", href: visuals_path).click
      expect(page).to have_no_selector("img[src$='test_image.png']")
    end

    it "admin以外でログインしている時は削除できない" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      # 外観/内装ボタンをクリック
      expect(page).to have_content("外観/内装")
      visit visuals_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_visual_path).click
      expect(current_path).to eq new_visual_path
      # フォームを入力する
      attach_file("visual[image]", "public/images/test_image.png", make_visible: true)
      select "外観", from: "visual[visual_category_id]"
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Visual.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # 外観/内装一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: visuals_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      # 削除ボタンがあることを確認する
      expect(page).to have_content("削除")
      # ログアウトする
      click_on "ログアウト"
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # 外装/内装一覧ページへ遷移する
      expect(page).to have_content("外観/内装")
      visit visuals_path
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content("削除")
    end
  end

  context "外観/内装の検索" do
    it "カテゴリーと検索ボタンが一致した場合に表示する" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 外観/内装ボタンをクリック
      expect(page).to have_content("外観/内装")
      visit visuals_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_visual_path).click
      expect(current_path).to eq new_visual_path
      # フォームを入力する
      attach_file("visual[image]", "public/images/test_image.png", make_visible: true)
      select "外観", from: "visual[visual_category_id]"
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Visual.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # 外観/内装一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: visuals_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      # 外観のラジオボタンをクリック
      find("#q_visual_category_id_eq_2").click 
      click_on "検索"
      # 投稿した内容が存在する
      expect(page).to have_selector("img[src$='test_image.png']")
    end

    it "検索が該当しない時" do
      # adminでログインする
      visit new_user_session_path
      fill_in "user[email]", with: "admin@admin.com"
      fill_in "user[password]", with: "000aaa"
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 外観/内装ボタンをクリック
      expect(page).to have_content("外観/内装")
      visit visuals_path
      # 新規作成ボタンをクリック
      find_link("新規作成", href: new_visual_path).click
      expect(current_path).to eq new_visual_path
      # フォームを入力する
      attach_file("visual[image]", "public/images/test_image.png", make_visible: true)
      select "外観", from: "visual[visual_category_id]"
      # 投稿するボタンをクリック
      expect do
        find('input[value="投稿する"]').click
      end.to change { Visual.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # 外観/内装一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: visuals_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      # 内装のラジオボタンをクリック
      find("#q_visual_category_id_eq_3").click
      click_on "検索"
      # 投稿した内容が存在しないことを確認する
      expect(page).to have_no_selector("img[src$='test_image.png']")
    end
  end
end

require 'rails_helper'

def basic_auth(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'ブログ', type: :system do
  before do
    @blog = FactoryBot.build(:blog)
    @user = FactoryBot.build(:user)
  end
  
  # seedファイルを読み込む
  before(:each) do
    load Rails.root.join('db/seeds.rb')
  end

  context 'ブログの投稿ができるとき' do
    it 'adminでログインしたときに投稿することができる' do
      # basic認証を入力する
      basic_auth new_user_session_path
      # adminでログインする
      fill_in 'user[email]', with: 'admin@admin.com'
      fill_in 'user[password]', with: '000aaa'
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ブログボタンをクリック
      expect(page).to have_content('ブログ')
      visit blogs_path
      # 新規投稿ボタンをクリック
      find_link('新規投稿', href: new_blog_path).click
      expect(current_path).to eq new_blog_path
      # フォームを入力する
      attach_file("blog[image]", "public/images/test_image.png", make_visible: true)
      fill_in "blog[title]", with: @blog.title
      fill_in "blog[text]", with: @blog.text
      # 投稿するボタンをクリックする
      expect do
        find('input[value="投稿する"]').click
      end.to change { Blog.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(page).to have_content("投稿が完了しました")
      # ブログ一覧ページに投稿した内装が存在する
      find_link("一覧へ戻る", href: blogs_path).click
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@blog.title)
    end
  end

  context "ブログの投稿ができない時" do
    it "admin以外でログインしているときは新規投稿ボタンが存在しない" do
      # ユーザー新規登録する
      user_regitstration(@user)
      # ログインする
      sign_in(@user)
      # ドリンク一覧ページへ遷移する
      expect(page).to have_content('ブログ')
      visit blogs_path
      # 新規投稿ボタンがないことを確認する
      expect(page).to have_no_content('新規投稿')
    end
  end
end
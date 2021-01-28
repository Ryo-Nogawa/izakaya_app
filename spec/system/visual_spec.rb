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
      expect(page).to have_content("外観/内装")
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
      expect(page).to have_content("投稿が完了しました")
      # 外観/内装一覧ページに投稿した内容が存在する
      find_link("一覧へ戻る", href: visuals_path).click
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
      expect(page).to have_content("外観/内装")
      visit visuals_path
      # 新規投稿ボタンがないことを確認する
      expect(page).to have_no_content("新規作成")
    end
  end

end
# frozen_string_literal: true

# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.14.1'

# Capistranoのログの表示に利用する
set :application, 'izakaya_app'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url, 'git@github.com:Ryo-Nogawa/izakaya_app.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.6.5' # カリキュラム通りに進めた場合、’2.6.5’ です

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/myawsec2key.pem']

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

# 通知
set :slack_url, "https://hooks.slack.com/services/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"
set :slack_channel, "Ryo Nogawa"

# 通知リスト
set :slack_notify_events, [:finished, :failed, :started]

# 通知のカスタマイズ
set :slack_fields, ['status', 'stage', 'branch', 'hosts']

# デプロイ開始
before 'slack:notify_starting', :deploy_starting do
  set :slack_emoji, ':pray:'
  set :slack_username, "デプロイ開始!"
end

# デプロイ成功
before 'slack:notify_finished', :deploy_success do
  set :slack_emoji, ':dancers:'
  set :slack_username, "デプロイ成功!!!"
end

# デプロイ失敗
before 'slack:notify_failed', :deploy_failure do
  set :slack_emoji, ':imp:'
  set :slack_username, "デプロイ失敗..."
end

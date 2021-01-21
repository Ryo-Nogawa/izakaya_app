# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Blog, type: :model do
  before do
    @blog = FactoryBot.build(:blog)
  end

  describe 'ブログの投稿' do
    context '投稿が有効な時' do
      it 'title, text, imageが存在している' do
        expect(@blog).to be_valid
      end
      it 'imageがなくても投稿できる' do
        @blog.image = nil
        expect(@blog).to be_valid
      end
    end

    context '投稿が無効な時' do
      it 'titleが空' do
        @blog.title = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include('タイトルを入力してください')
      end
      it 'titleが100文字以上' do
        @blog.title = Faker::Lorem.characters(number: 200)
        @blog.valid?
        expect(@blog.errors.full_messages).to include('タイトルは100文字以内で入力してください')
      end
      it 'textが空' do
        @blog.text = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include('テキストを入力してください')
      end
      it 'textが3000文字以上' do
        @blog.text = Faker::Lorem.characters(number: 4000)
        @blog.valid?
        expect(@blog.errors.full_messages).to include('テキストは3000文字以内で入力してください')
      end
    end
  end
end

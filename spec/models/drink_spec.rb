# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Drink, type: :model do
  before do
    @drink = FactoryBot.build(:drink)
  end

  describe 'ドリンク投稿' do
    context 'ドリンク投稿が有効な時' do
      it 'drink_category_id, title, detail, price, imageが存在する' do
        expect(@drink).to be_valid
      end
    end

    context 'ドリンク投稿が無効な時' do
      it 'drink_category_idが1' do
        @drink.drink_category_id = 1
        @drink.valid?
        expect(@drink.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
      end
      it 'titleが空' do
        @drink.title = nil
        @drink.valid?
        expect(@drink.errors.full_messages).to include('商品名を入力してください')
      end
      it 'titleが41文字以上' do
        @drink.title = Faker::Lorem.characters(number: 50)
        @drink.valid?
        expect(@drink.errors.full_messages).to include('商品名は40文字以内で入力してください')
      end
      it 'detailが空' do
        @drink.detail = nil
        @drink.valid?
        expect(@drink.errors.full_messages).to include('詳細を入力してください')
      end
      it 'detailが250文字以上' do
        @drink.detail = Faker::Lorem.characters(number: 300)
        @drink.valid?
        expect(@drink.errors.full_messages).to include('詳細は250文字以内で入力してください')
      end
      it 'priceが空' do
        @drink.price = nil
        @drink.valid?
        expect(@drink.errors.full_messages).to include('値段を入力してください')
      end
      it 'priceが9,999,999以上' do
        @drink.price = Faker::Number.between(from: 10_000_000)
        @drink.valid?
        expect(@drink.errors.full_messages).to include('値段は整数で入力してください')
      end
      it 'imageが空' do
        @drink.image = nil
        @drink.valid?
        expect(@drink.errors.full_messages).to include('画像を入力してください')
      end
    end
  end
end

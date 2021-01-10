require 'rails_helper'

RSpec.describe Food, type: :model do
  before do
    @food = FactoryBot.build(:food)
  end

  describe 'フード投稿' do
    context 'フード投稿が有効な時' do
      it 'food_category_id, title, detail, price, imageが存在する' do
        expect(@food).to be_valid
      end
    end

    context 'フード投稿が無効な時' do
      it 'food_category_idが1' do
        @food.food_category_id = 1
        @food.valid?
        expect(@food.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
      end
      it 'titleが空' do
        @food.title = nil
        @food.valid?
        expect(@food.errors.full_messages).to include('商品名を入力してください')
      end
      it 'titleが41文字以上' do
        @food.title = Faker::Lorem.characters(number: 50)
        @food.valid?
        expect(@food.errors.full_messages).to include('商品名は40文字以内で入力してください')
      end
      it 'detailが空' do
        @food.detail = nil
        @food.valid?
        expect(@food.errors.full_messages).to include('詳細を入力してください')
      end
      it 'detailが250文字以上' do
        @food.detail = Faker::Lorem.characters(number: 300)
        @food.valid?
        expect(@food.errors.full_messages).to include('詳細は250文字以内で入力してください')
      end
      it 'priceが空' do
        @food.price = nil
        @food.valid?
        expect(@food.errors.full_messages).to include('値段を入力してください')
      end
      it 'priceが9,999,999以上' do
        @food.price = Faker::Number.between(from: 10_000_000)
        @food.valid?
        expect(@food.errors.full_messages).to include('値段は整数で入力してください')
      end
      it 'imageが空' do
        @food.image = nil
        @food.valid?
        expect(@food.errors.full_messages).to include('画像を入力してください')
      end
    end
  end
end

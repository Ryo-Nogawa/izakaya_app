# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodComment, type: :model do
  before do
    @food_comment = FactoryBot.build(:food_comment)
  end

  describe 'フードコメント投稿' do
    context 'フードコメントが有効な時' do
      it 'commentが存在する' do
        expect(@food_comment).to be_valid
      end
    end

    context 'フードコメントが無効な時' do
      it 'commentが空' do
        @food_comment.comment = nil
        @food_comment.valid?
        expect(@food_comment.errors.full_messages).to include('コメントを入力してください')
      end
      it 'commentが250文字以上' do
        @food_comment.comment = Faker::Lorem.characters(number: 300)
        @food_comment.valid?
        expect(@food_comment.errors.full_messages).to include('コメントは250文字以内で入力してください')
      end
    end
  end
end

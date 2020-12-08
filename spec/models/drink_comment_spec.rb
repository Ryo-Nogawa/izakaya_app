require 'rails_helper'

RSpec.describe DrinkComment, type: :model do
  before do
    @drink_comment = FactoryBot.build(:drink_comment)
  end

  describe 'ドリンクコメント投稿' do
    context 'ドリンクコメントが有効な時' do
      it 'commentが存在する' do
        expect(@drink_comment).to be_valid
      end
    end

    context 'ドリンクコメントが無効な時' do
      it 'commentが空' do
        @drink_comment.comment = nil
        @drink_comment.valid?
        expect(@drink_comment.errors.full_messages).to include('コメントを入力してください')
      end
      it 'commentが250文字以上' do
        @drink_comment.comment = Faker::Lorem.characters(number: 300)
        @drink_comment.valid?
        expect(@drink_comment.errors.full_messages).to include('コメントは250文字以内で入力してください')
      end
    end
  end
end

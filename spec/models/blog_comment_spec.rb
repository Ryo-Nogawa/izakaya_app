require 'rails_helper'

RSpec.describe BlogComment, type: :model do
  before do
    @blog_comment = FactoryBot.build(:blog_comment)
  end

  describe 'ブログにコメント投稿' do
    context 'commentが有効な時' do
      it 'commentが存在する' do
        expect(@blog_comment).to be_valid
      end
    end

    context 'commentが無効な時' do
      it 'commentが空' do
        @blog_comment.comment = nil
        @blog_comment.valid?
        expect(@blog_comment.errors.full_messages).to include('コメントを入力してください')
      end
      it 'commentが250文字以上' do
        @blog_comment.comment = Faker::Lorem.characters(number: 300)
        @blog_comment.valid?
        expect(@blog_comment.errors.full_messages).to include('コメントは250文字以内で入力してください')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ投稿' do
    context 'メッセージが送信できる時' do
      it 'contentが存在する' do
        expect(@message).to be_valid
      end
    end

    context 'メッセージが送信できない時' do
      it 'contentが空' do
        @message.content = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('メッセージを入力してください')
      end
      it 'contentが250文字以上' do
        @message.content = Faker::Lorem.characters(number: 300)
        @message.valid?
        expect(@message.errors.full_messages).to include('メッセージは250文字以内で入力してください')
      end
    end
  end
end

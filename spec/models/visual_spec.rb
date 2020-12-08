require 'rails_helper'

RSpec.describe Visual, type: :model do
  before do
    @visual = FactoryBot.build(:visual)
  end

  describe '外観/内装の投稿' do
    context '投稿が有効な時' do
      it 'imageが存在する' do
        expect(@visual).to be_valid
      end
    end

    context '投稿が無効な時' do
      it 'imageが空' do
        @visual.image = nil
        @visual.valid?
        expect(@visual.errors.full_messages).to include('画像を入力してください')
      end
    end
  end
end

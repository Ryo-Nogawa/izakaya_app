require 'rails_helper'

RSpec.describe Reserve, type: :model do
  before do
    @reserve = FactoryBot.build(:reserve)
  end

  describe '予約' do
    context '予約が有効な場合' do
      it 'reserve_date, reserve_time, number_reserve, reserve_category_idが存在する' do
        expect(@reserve).to be_valid
      end
    end

    context '予約が無効な場合' do
      it 'reserve_dateが過去の日付' do
        @reserve.reserve_date = Faker::Date.between(from: 1.year.ago, to: Date.today)
        @reserve.valid?
        expect(@reserve.errors.full_messages).to include('御予約日時は今日以降のものを選択してください')
      end
      it 'reserve_timeが空' do
        @reserve.reserve_time = nil
        @reserve.valid?
        expect(@reserve.errors.full_messages).to include('御予約時間を入力してください')
      end
      it 'number_reserveが1' do
        @reserve.number_reserve = 1
        @reserve.valid?
        expect(@reserve.errors.full_messages).to include('御予約人数は1より大きい値にしてください')
      end
      it 'number_reserveが20以上' do
        @reserve.number_reserve = Faker::Number.between(from: 21, to: 99)
        @reserve.valid?
        expect(@reserve.errors.full_messages).to include('御予約人数は20より小さい値にしてください')
      end
      it 'number_reserveが空' do
        @reserve.number_reserve = nil
        @reserve.valid?
        expect(@reserve.errors.full_messages).to include('御予約人数を入力してください')
      end
      it 'reserve_category_idが1' do
        @reserve.reserve_category_id = 1
        @reserve.valid?
        expect(@reserve.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
      end
    end
  end
end

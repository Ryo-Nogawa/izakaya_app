# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = FactoryBot.build(:book)
  end

  describe '予約する' do
    context '予約が完了する時' do
      it 'reserve_date, reserve_time, number_reserve, reserve_category_idが存在する時' do
        expect(@book).to be_valid
      end
    end

    context '予約が失敗する時' do
      it 'reserve_dateが過去の日付' do
        @book.reserve_date = '2020-12-30'
        @book.valid?
        expect(@book.errors.full_messages).to include('御予約日時は明日以降の日付を選択してください')
      end
      it 'reserve_timeが空' do
        @book.reserve_time = nil
        @book.valid?
        expect(@book.errors.full_messages).to include('御予約時間を入力してください')
      end
      it 'number_reserveが1' do
        @book.number_reserve = 1
        @book.valid?
        expect(@book.errors.full_messages).to include('御予約人数は1より大きい値にしてください')
      end
      it 'number_reserveが21以上' do
        @book.number_reserve = Faker::Number.between(from: 21, to: 100)
        @book.valid?
        expect(@book.errors.full_messages).to include('御予約人数は21より小さい値にしてください')
      end
      it 'reserve_category_idが1' do
        @book.reserve_category_id = 1
        @book.valid?
        expect(@book.errors.full_messages).to include('御予約内容は1以外の値にしてください')
      end
    end
  end
end
